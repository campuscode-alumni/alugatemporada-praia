require 'rails_helper'

feature 'Visitor view property details' do
  scenario 'successfully' do
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    property = Property.create!(title: 'Casa charmosa em Ubatuba', property_type: 'casa',
              description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Ubatuba',
              rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
              total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
              daily_rate: '300.00', owner: owner1)

    visit root_path

    click_on property.title

    expect(page).to have_css('h1', text: property.title)
    expect(page).to have_css('h3', text: property.property_type)
    expect(page).to have_css('p', text: property.property_location)
    expect(page).to have_css('p', text: property.description)
    expect(page).to have_css('p', text: "Finalidade da locação: #{property.rent_purpose}")
    expect(page).to have_css('p', text: "Acessibilidade: Sim")
    expect(page).to have_css('p', text: "Aceita animais: Sim")
    expect(page).to have_css('p', text: "Aceita fumantes: Não")
    expect(page).to have_css('p', text: "#{property.total_rooms} quartos")
    expect(page).to have_css('p', text: "Número máximo de hóspedes: #{property.maximum_guests}")
    expect(page).to have_css('p', text: "Locação de #{property.minimum_rent} a #{property.maximum_rent} dias")
    expect(page).to have_css('p', text: "Valor da diária: R$ 300,00")
  end
end
