class Api::V1::UsersController < ApplicationController
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

  def show
    if params['username']
      response = TorreService.get_person_by_username(params['username'])
      @person = JSON.parse(response)
      render json: @person
    else
      response = TorreService.get_opportunity_by_id(params['id'])
      @opportunity = JSON.parse(response)
      render json: @opportunity
    end
  end

  private
  def user_params
    params.require(:person).permit(:username)
  end
end
