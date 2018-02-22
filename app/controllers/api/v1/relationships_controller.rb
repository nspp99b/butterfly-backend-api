class Api::V1::RelationshipsController < ApplicationController

  def index
    @relationships = Relationship.all
    render json: @relationships
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      render json: @relationship
    else
      render json: { error: "There was a problem.." }
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:cause_id, :effect_id)
  end

end
