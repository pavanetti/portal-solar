class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = if params[:query].present?
      PowerGenerator.by_term params[:query]
    else
      PowerGenerator.all
    end
  end
end
