class Api::V1::FlapsController < ApplicationController

  def index
    flaps = Flap.all.order(created_at: :desc).map { |f| f.to_json }
    render json: flaps
  end

  def create
    flap = Flap.new(flap_params)
    if flap.save
      flaps = Flap.all.order(created_at: :desc).map { |f| f.to_json }
      render json: flaps
    else
      render json: { error: "Max char length is 250" }
    end
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
