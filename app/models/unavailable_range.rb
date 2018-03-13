class UnavailableRange < ApplicationRecord
  validates :start_date, presence: { message: 'Preencha a data inicial'}
  validates :end_date, presence: { message: 'Preencha a data final'}
  validates :description, presence: { message: 'Preencha a descrição'}
  belongs_to :property

  validate :conflit_date
  def conflit_date
    busca_inicial_date = :property.where()
    if :start_date >
      errors.add(:base, "can't be in the past")
    end
  end
end
