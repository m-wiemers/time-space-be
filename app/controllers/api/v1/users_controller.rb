module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: User.all, status: 200
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        User.find(params[:id]).destroy!

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :name)
      end
    end
  end
end