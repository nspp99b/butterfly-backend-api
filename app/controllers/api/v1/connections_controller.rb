class Api::V1::ConnectionsController < ApplicationController

  def create
    user = User.find(connection_params[:followed_id])
    current_user.follow(user)
    render json: user
  end

  def destroy
    user = Connection.find(params[:id]).followed
    current_user.unfollow(user)
    render json: user
  end

  private

  def connection_params
    params.require(:connection).permit(:follower_id, :followed_id)
  end

end
