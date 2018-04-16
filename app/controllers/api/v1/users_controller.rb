class Api::V1::UsersController < ApplicationController

  def index
    users = User.all.order(:name)
    render json: users
  end

  def show
    @user = User.find(params[:id])
    flaps = @user.flaps.order(created_at: :desc).map { |f| f.to_json }
    render json: { @user, flaps: flaps }
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user
    else
      render json: { error: "Make sure your password is 6 chars long" }
    end
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

end
