class PowerGenerator < ApplicationRecord
  validates :name, :description, :image_url, :manufacturer, :price, :kwp, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }
  validates :width, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :lenght, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3000 }

  enum structure_type: %i[
    metalico
    ceramico
    fibrocimento
    laje
    solo
    trapezoidal
  ]

  scope :by_term, -> (term) {
    term = term.split.join(' & ')
    where "to_tsvector('english', name || ' ' || description) @@ to_tsquery('english', ?)", term
  }

  scope :by_manufacturer, -> (manufacturer) {
    if manufacturer.present?
      where manufacturer: manufacturer
    else
      all
    end
  }
  scope :by_structure_type, -> (structure_type) {
    if structure_type.present?
      where structure_type: structure_type
    else
      all
    end
  }
  scope :by_min_power, -> (min_power) {
    if min_power.present?
      where arel_table[:kwp].gteq(min_power)
    else
      all
    end
  }
  scope :by_max_price, -> (max_price) {
    if max_price.present?
      where arel_table[:price].lteq(max_price)
    else
      all
    end
  }
  scope :by_max_dimension, -> (dimension, max_dimension) {
    if [:height, :width, :lenght].include?(dimension) && max_dimension.present?
      where arel_table[dimension].lteq(max_dimension)
    else
      all
    end
  }

  def self.by_advanced_search params
    by_manufacturer(params[:manufacturer])
      .by_structure_type(params[:structure_type])
      .by_min_power(params[:kwp])
      .by_max_price(params[:price])
      .by_max_dimension(:height, params[:height])
      .by_max_dimension(:width, params[:width])
      .by_max_dimension(:lenght, params[:lenght])
  end

end
