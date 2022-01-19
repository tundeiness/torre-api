module Api
  module V1
    class PersonsController < ApplicationController
      def index
        @response = RestClient.get 'https://torre.bio/api/bios/john', { content_type: :json, accept: :json }

        @person_details = JSON.parse(@response.body)["person"]["flags"]
        render json: @person_details, status: :ok
      end
    end
  end
end

