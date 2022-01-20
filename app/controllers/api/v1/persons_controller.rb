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
        response = RestClient.get 'https://torre.bio/api/bios/' + name , { content_type: :json, accept: :json }

        full_details = JSON.parse(response.body)
        @filtered_detail = {
          'name': full_details['person']['name'],
          'headline': full_details['person']['professionalHeadline'],
          'picture': full_details['person']['picture'],
          'pictureThumb': full_details['person']['pictureThumbnail'],
          'strengths': full_details['strengths']
        }
        render json: @filtered_detail, status: :ok
      end

      private

      def person_params
        params.permit(:username)
      end
    end
  end
end
