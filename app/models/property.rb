class Property < ApplicationRecord
  validates :title, presence: { message: 'Você deve preencher o título.'}
  validates :property_type, presence: { message: 'Você deve preencher o campo tipo da propriedade.'}
  validates :description, presence: { message: 'Você deve preencher o campo descrição.'}
  validates :location, presence: { message: 'Você deve preencher o campo localização.'}
  validates :rent_purpose, presence: { message: 'Você deve preencher o campo finalidade da locação.'}
  validates :total_rooms, presence: { message: 'Você deve preencher o campo total de quartos.'}
  validates :maximum_guests, presence: { message: 'Você deve preencher o campo número máximo de hóspedes.'}
  validates :minimum_rent, presence: { message: 'Você deve preencher o campo número minimo de dias para locação.'}
  validates :maximum_rent, presence: { message: 'Você deve preencher o campo número máximo de dias para locação.'}
  validates :daily_rate, presence: { message: 'Você deve preencher o campo valor da diária.'}
end
