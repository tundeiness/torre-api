class Api::V1::UsersController < Api::V1::ApiController
  API_ENDPOINT = 'https://torre.bio/api'.freeze
  def index
    binding.pry
    res = RestClient.get("https://torre.bio/api/bios/john")
    @user = JSON.parse(res)
    render json: @user
    # binding.pry
    # @books = params[:category] ? Book.categorized(params[:category]) : Book.all
    #  render json: @books
  end

  def get_user(name)
    #res = RestClient.get("https://torre.bio/api/bios/#{name}")
    #@user = JSON.parse(res)
    #render json: @user

    @client = Faraday.new do |builder|
      builder.use :http_cache, store: Rails.cache, logger: ActiveSupport::Logger.new(STDOUT)
      builder.adapter Faraday.default_adapter
      builder.response :json, :content_type => /\bjson$/
      builder.use Faraday::OverrideCacheControl, cache_control: 'public, max-age=3600'
    end

    started = Time.now

    response = @client.get("https://torre.bio/api/bios/#{name}")
    finished = Time.now

    puts " Request took #{(finished - started) * 1000} ms."
    response.body
  end

  def get(url, params)
    res = Rails.cache.fetch([url, params], :expires => 1.hour) do
      Faraday.get('url/to/api')
    end

    render json: res
  end

  def torre_user(username)
    request(
      http_method: :get,
      endpoint: "bios/#{username}"
    )
  end

  private
  def client
    @_client ||= Faraday.new(API_ENDPOINT) do |client|
      client.request :url_encoded
      client.adapter Faraday.default_adapter
      # client.headers['Authorization'] = "token #{oauth_token}" if oauth_token.present?
    end
  end

  def request(http_method:, endpoint:, params: {})
    response = client.public_send(http_method, endpoint, params)
    # Oj.load(response.body)
    # response.body
    JSON.parse(response.body)
    # render json: @user
  end
end
