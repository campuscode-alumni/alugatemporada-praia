class Proposal < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2 }

  scope :not_rejected, -> {
    where.not(status: :rejected)
  }

  belongs_to :property
  belongs_to :user
  validates :phone, :rent_purpose, :maximum_guests,
  :start_date, :end_date, presence:
  {message: 'Você deve preencher todos os campos para enviar uma proposta'}

  def smoking_allowed?
     if smoking_allowed
       return "Sim"
     else
       return "Não"
     end
  end

  def petfriendly?
    if petfriendly
      return "Sim"
    else
      return "Não"
    end
  end
end
