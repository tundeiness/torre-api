module Api
  module V1
    class PersonsController < ApplicationController
      before_action :person_params

      def show
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
