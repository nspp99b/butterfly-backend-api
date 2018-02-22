class UsersController < ApplicationController

  def index
    @users = User.all.order(:name).limit(30)
    render json: @users
  end

  def show
    @user = User.find_by(params[:id])
    render json: @user
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

end
