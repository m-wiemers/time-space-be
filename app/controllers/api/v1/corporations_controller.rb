module Api
  module V1
    class CorporationsController < ApplicationController
      def index
        corporations = Corporation.all
        render json: CorporationRepresenter.new(corporations).as_json, status: 200
      end

      def create
        corporation = Corporation.new(corp_params)

        if corporation.save
          render json: corporation, status: :created
        else
          render json: corporation.errors, status: :unprocessable_entity
        end
      end
  
      def destroy
        Corporation.find(params[:id]).destroy!

        head :no_content
      end

      private

      def corp_params
        params.require(:corporation).permit(:name, :location)
      end
    end
  end
end