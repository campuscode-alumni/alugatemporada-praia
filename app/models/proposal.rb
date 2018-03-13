class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  validates :phone, :rent_purpose, :maximum_guests,
  :start_date, :end_date, presence:
  {message: 'Você deve preencher todos os campos para enviar uma proposta'}

end
