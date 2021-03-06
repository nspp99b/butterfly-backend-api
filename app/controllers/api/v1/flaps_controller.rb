class Api::V1::FlapsController < ApplicationController

  def index
    user = current_user
    flaps = user.feed.order(created_at: :desc)
    render json: flaps
  end

  def create
    flap = Flap.new(content: flap_params[:content], user_id: flap_params[:user_id])
    if flap.save
      Relationship.create(cause_id: params[:parent], effect_id: flap.id) unless params[:parent] === "null"
      user = current_user
      flaps = user.feed.order(created_at: :desc)
      render json: flaps
    else
      render json: { error: "Max char length is 250" }
    end
  end

  def update
    user = current_user
    flap = Flap.find(params[:id])
    flap.active = !flap.active
    flap.save
    flaps = user.feed.order(created_at: :desc)
    render json: flaps
  end

  def show
    flap = Flap.find_by(id: params[:id])
    render json: flap
  end

  private

  def flap_params
    params.require(:flap).permit(:content, :user_id)
  end

end
