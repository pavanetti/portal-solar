module FreightsHelper
  include ActionView::Helpers::NumberHelper

  def as_brazilian_currency(number)
    number_to_currency(number, unit: "R$ ", separator: ",", delimiter: ".")
  end
end
