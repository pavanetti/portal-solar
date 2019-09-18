class SearchController < ApplicationController
  def simple
    @power_generators = PowerGenerator.by_term params[:terms]
    render 'power_generators/index'
  end

  def advanced
  end
end
