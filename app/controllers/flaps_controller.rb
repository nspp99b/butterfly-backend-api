class FlapsController < ApplicationController

  def index
    @flaps = Flap.all.order(created_at: :desc)
    render json: @flaps
  end

  def create
    @flap = Flap.new(flap_params)
    if @flap.save
      flash[:success] = "Flapped!"
      render json: @flap
    else
      flash[:error] = 
      redirect_to request.referrer
  end
  end

  def show
    @flap = Flap.find_by(params[:id])
    render json: @flap
  end

  private

  def flap_params
    params.require(:flap).permit(:content, :user_id)
  end

end
