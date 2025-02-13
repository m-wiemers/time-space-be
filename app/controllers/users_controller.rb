class UsersController < ApplicationController
  def index
    render json: User.all, status: 200
  end

  def create
  end
end
