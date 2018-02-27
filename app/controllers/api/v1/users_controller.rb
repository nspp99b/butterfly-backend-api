class Api::V1::UsersController < ApplicationController

  def index
    users = User.all.order(:name).limit(30)
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    flaps = user.flaps.map {|f| f.to_json}
    render json: { user: user.to_json, flaps: flaps }
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

end
