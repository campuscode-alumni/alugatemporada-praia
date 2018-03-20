require 'rails_helper'

feature 'owner sees properties' do
  scenario 'successfully' do

    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    property = Property.create(title: 'Casa maravilhosa em Ubatuba', property_type: 'casa',
              description: 'Casa nova, com quartos climatizados e wi-fi',
              property_location: 'Ubatuba', rent_purpose: 'férias',
              accessibility: true, petfriendly: true, smoking_allowed: false,
              total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
              maximum_rent: '30', daily_rate: '300', owner: owner1)

    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: 'proprietario@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Meus imóveis'

    expect(page).to have_content 'Casa maravilhosa em Ubatuba'
    expect(page).to have_content 'R$ 300,00 por dia'
    expect(page).to have_content "Máx. Hospedes: #{property.maximum_guests}"
    expect(page).to have_content 'Ubatuba'

  end

  scenario 'and logs off session' do
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    property = Property.create(title: 'Casa maravilhosa em Ubatuba', property_type: 'casa',
              description: 'Casa nova, com quartos climatizados e wi-fi',
              property_location: 'Ubatuba', rent_purpose: 'férias',
              accessibility: true, petfriendly: true, smoking_allowed: false,
              total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
              maximum_rent: '30', daily_rate: '300', owner: owner1)

    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: 'proprietario@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).not_to have_content 'Meus imóveis'
  end

end
