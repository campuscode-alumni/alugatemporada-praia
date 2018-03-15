require 'rails_helper'

feature 'Calculate proposal' do
  scenario 'successfully' do
    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba',
      property_type: 'casa', description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Ubatuba', rent_purpose: 'férias', accessibility: true,
      petfriendly: true, smoking_allowed: false, total_rooms: '2',
      maximum_guests: '8', minimum_rent: '5', maximum_rent: '30', daily_rate: '300.00')

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    proposal = Proposal.create(phone: '11-987654321',
      rent_purpose: 'Feriado e final de semana', maximum_guests: 5,
      start_date: '13/02/2019', end_date: '16/02/2019', smoking_allowed: true,
    petfriendly: false, property: property, user: user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Minhas propostas'

    expect(page).to have_css('li', text: 'Feriado e final de semana')
    expect(page).to have_css('li', text: 'R$ 4000,00')
    expect(page).to have_css('li', text: '13/02/2019')
    expect(page).to have_css('li', text: '16/02/2019')

    end
end
