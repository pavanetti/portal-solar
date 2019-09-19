class FreightsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def show
    state = params[:state]
    power_generator = PowerGenerator.find(params[:generator])
    freigths = Freight
      .where(state: state)
      .where(Freight.arel_table[:weight_min].lteq(power_generator.cubed_weight))
      .where(Freight.arel_table[:weight_max].gteq(power_generator.cubed_weight))
    respond_to do |format|
      format.json do
        render json: {
          cost: number_to_currency(freigths.pluck(:cost).min, unit: "R$ ", separator: ",", delimiter: ".")
        }
      end
    end
  end
end
