class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  enum status: [ :pending, :accepted, :rejected ]
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
