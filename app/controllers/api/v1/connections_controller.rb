class Api::V1::ConnectionsController < ApplicationController

  def index
    conxs = Connection.all
    render json: conxs
  end

  def create
    conx = Connection.new(connection_params)
    if conx.save
      render json: conx
    else
      render json: { error: "Connection must have follower and followed" }
    end
  end

  def unfollow
    user = Connection.find_by(connection_params).followed
    cu = current_user
    cu.unfollow(user)
    render json: { user: user.to_json, currentUser: cu.to_json }
  end

  private

  def connection_params
    params.require(:connection).permit(:follower_id, :followed_id)
  end

end
