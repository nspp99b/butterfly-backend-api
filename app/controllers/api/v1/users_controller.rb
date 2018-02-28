class Api::V1::UsersController < ApplicationController

  def index
    users = User.all.order(:name).limit(30)
    render json: users
  end

  def show
    user = User.find(params[:id]).to_json
    flaps = user.flaps.order(created_at: :desc).map { |f| f.to_json }
    render json: { user: user, flaps: flaps }
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

end
