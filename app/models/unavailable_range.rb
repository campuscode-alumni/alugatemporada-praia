class UnavailableRange < ApplicationRecord
  validates :start_date, presence: { message: 'Preencha a data inicial'}
  validates :end_date, presence: { message: 'Preencha a data final'}
  validates :description, presence: { message: 'Preencha a descrição'}
  belongs_to :property

  validate :conflit_date

  private

  def conflit_date
    if start_date && end_date && property
      x = property.unavailable_ranges.where("start_date < ? AND end_date >= ?", start_date, start_date)
      if x.any?
        errors.add(:base, "esse período já está indisponível")
      end
    end
  end

end
