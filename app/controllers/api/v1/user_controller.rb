class Api::V1::UserController < Api::V1::ApiController
 
  def index
    binding.pry
    res = RestClient.get("https://torre.bio/api/bios/john")
    @user = JSON.parse(res)

    # @books = params[:category] ? Book.categorized(params[:category]) : Book.all
    #  render json: @books
  end
end
