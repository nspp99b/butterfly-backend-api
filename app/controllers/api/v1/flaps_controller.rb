class Api::V1::FlapsController < ApplicationController

  def index
    user = current_user
    flaps = user.feed.order(created_at: :desc)
    render json: flaps, include: [
      'user',
      'effects',
      'user.following',
      'user.followers',
      'effects.id',
      'effects.content',
      'effects.created_at',
      'effects.user',
      'effects.user.following',
      'effects.user.followers',
      'effects.fxc'
    ]
  end

  def create
    flap = Flap.new(content: flap_params[:content], user_id: flap_params[:user_id])
    if flap.save
      Relationship.create(cause_id: params[:parent], effect_id: flap.id) unless params[:parent] === "null"
      user = current_user
      flaps = user.feed.order(created_at: :desc)
      render json: flaps, include: [
        'user',
        'effects',
        'user.following',
        'user.followers',
        'effects.id',
        'effects.content',
        'effects.created_at',
        'effects.user',
        'effects.user.following',
        'effects.user.followers',
        'effects.fxc'
      ]
    else
      render json: { error: "Max char length is 250" }
    end
  end

  def update
    user = current_user
    flap = Flap.find(params[:id])
    flap.active = !flap.active
    flap.save
    render json: flap, include: [
      'user',
      'effects',
      'user.following',
      'user.followers',
      'effects.id',
      'effects.content',
      'effects.created_at',
      'effects.user',
      'effects.user.following',
      'effects.user.followers',
      'effects.fxc'
    ]
  end

  def show
    @flap = Flap.find_by(id: params[:id])
    render json: @flap, include: [
      'user',
      'effects',
      'user.following',
      'user.followers',
      'effects.id',
      'effects.content',
      'effects.created_at',
      'effects.user',
      'effects.user.following',
      'effects.user.followers',
      'effects.fxc'
    ]
  end

  private

  def flap_params
    params.require(:flap).permit(:content, :user_id)
  end

end
