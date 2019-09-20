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

  effectless_scope :by_manufacturer, -> (m) { where manufacturer: m }
  effectless_scope :by_structure_type, -> (st) { where structure_type: st }
  effectless_scope :by_min_power, -> (min_power) { where arel_table[:kwp].gteq(min_power) }
  effectless_scope :by_max_price, -> (max_price) { where arel_table[:price].lteq(max_price) }
  effectless_scope :by_max_height, -> (max_height) { where arel_table[:height].lteq(max_height) }
  effectless_scope :by_max_width, -> (max_width) { where arel_table[:width].lteq(max_width) }
  effectless_scope :by_max_length, -> (max_length) { where arel_table[:lenght].lteq(max_length) }

  def self.by_advanced_search params
    by_manufacturer(params[:manufacturer])
      .by_structure_type(params[:structure_type])
      .by_min_power(params[:kwp])
      .by_max_price(params[:price])
      .by_max_height(params[:height])
      .by_max_width(params[:width])
      .by_max_length(params[:length])
  end

  def cubed_weight
    height * width * lenght * 300
  end

end
