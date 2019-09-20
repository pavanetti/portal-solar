class FreightsController < ApplicationController
  include FreightsHelper
  def show
    state = params[:state]
    power_generator = PowerGenerator.find(params[:generator])
    freigths = Freight
      .where(state: state)
      .where(Freight.arel_table[:weight_min].lteq(power_generator.cubed_weight))
      .where(Freight.arel_table[:weight_max].gteq(power_generator.cubed_weight))
    render json: { cost: as_brazilian_currency(freigths.pluck(:cost).min) }
  end
end
