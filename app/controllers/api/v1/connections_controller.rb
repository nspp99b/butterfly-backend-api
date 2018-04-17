class Api::V1::ConnectionsController < ApplicationController

  def index
    conxs = Connection.all
    render json: conxs, include:
    ['follower',
      'followed',
      'follower.followers',
      'follower.following',
      'followed.followers',
      'followed.following'
    ]
  end

  def create
    conx = Connection.new(connection_params)
    @user = conx.followed
    @cu = current_user
    if conx.save
      render json: conx, include:
      ['follower',
        'followed',
        'follower.followers',
        'follower.following',
        'followed.followers',
        'followed.following'
      ]
    else
      render json: { error: "Connection must have follower and followed" }
    end
  end

  def unfollow
    @user = Connection.find_by(connection_params).followed
    @cu = current_user
    @cu.unfollow(@user)
    render json: { user: UserSerializer.new(@user), currentUser: UserSerializer.new(@cu) }
  end

  private

  def connection_params
    params.require(:connection).permit(:follower_id, :followed_id)
  end

end
