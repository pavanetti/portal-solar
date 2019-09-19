class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = case search_type
      when :simple
        PowerGenerator.by_term params[:query]
      when :advanced
        PowerGenerator.by_advanced_search advanced_search_params
      when :none
        PowerGenerator.all
    end
  end

  private
  def search_type
    if params[:query].present?
      :simple
    elsif params[:advanced].present?
      :advanced
    else
      :none
    end
  end

  def advanced_search_params
    params.require(:power_generator).permit([
      :manufacturer, :structure_type, :kwp,
      :price, :height, :width, :length
    ])
  end
end
