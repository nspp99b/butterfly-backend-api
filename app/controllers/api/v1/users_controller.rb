class Api::V1::UsersController < ApplicationController

  def index
    users = User.all.order(:name)
    render json: users
  end

  def show
    user = User.find(params[:id])
    flaps = user.flaps.order(created_at: :desc).map { |f| f.to_json }
    render json: { user: user, flaps: flaps }
  end

  def following
    user = User.find(params[:id])
    users = user.following.order(:name)
    render json: users
  end

  def followers
    user = User.find(params[:id])
    users = user.followers.order(:name)
    render json: users
  end
  # private
  #
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

end
