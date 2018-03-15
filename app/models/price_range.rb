class PriceRange < ApplicationRecord
  belongs_to :property
  validates :description, :start_date, :end_date, :daily_rate, presence: true

  validate :end_date_smaller_than_start_date, if: :dates_blank?
  validate :exist_price_range


  def dates_blank?
    start_date && end_date
  end

  def end_date_smaller_than_start_date
    if end_date < start_date
      errors.add(:end_date, 'A data fim não pode ser menor do que a data início')
    end
  end

  def exist_price_range
    exist_price_range = property.price_ranges.where("(start_date <= ? or end_date >= ?)
       and (start_date >= ? or end_date <= ?)
       ", start_date, start_date, end_date, end_date)

    if exist_price_range.any?
        errors.add(:exist_price_range, 'A data informada já consta cadastrada em outra temporada')
    end
  end
end
#or (start_date between ? and ? or end_date between ? and ?)
