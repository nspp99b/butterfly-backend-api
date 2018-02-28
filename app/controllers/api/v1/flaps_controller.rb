class Api::V1::FlapsController < ApplicationController

  def index
    flaps = Flap.all.order(created_at: :desc).map { |f| f.to_json }
    render json: flaps
  end

  def create
    # byebug
    flap = Flap.new(content: flap_params[:content], user_id: flap_params[:user_id])
    if flap.save
      Relationship.create(cause_id: params[:parent], effect_id: flap.id) unless params[:parent] = "null"
      flaps = Flap.all.order(created_at: :desc).map { |f| f.to_json }
      render json: flaps
    else
      render json: { error: "Max char length is 250" }
    end
  end

  def update
    flap = Flap.find(params[:id])
    flap.active = !flap.active
    flap.save
    flaps = Flap.all.order(created_at: :desc).map { |f| f.to_json }
    render json: flaps
  end

  def show
    flap = Flap.find_by(id: params[:id]).to_json
    render json: flap
  end

  private

  def flap_params
    params.require(:flap).permit(:content, :user_id)
  end

end
