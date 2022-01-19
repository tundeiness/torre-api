module Api
  module V1
    class PersonsController < ApplicationController
      before_action :person_params

      def index
        @response = RestClient.get `https://torre.bio/api/bios/#{params[:id]}`, { content_type: :json, accept: :json }

        @person_details = JSON.parse(@response.body)["person"]["flags"]
        render json: @person_details, status: :ok
      end

      def show 
        #binding.pry
        name = params[:username]
        @response = RestClient.get 'https://torre.bio/api/bios/' + name , { content_type: :json, accept: :json }

        @person_details = JSON.parse(@response.body)['person']['flags']
        render json: @person_details, status: :ok
      end

      private

      def person_params
        params.permit(:username)
      end
    end
  end
end
