class PriceRange < ApplicationRecord
  belongs_to :property
  validates :description, :start_date, :end_date, :daily_rate, presence: true
end
