requires 'rails_helpers'

feature 'owner sees properties' do
  scenario 'successfully' do

    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')

    Property.create(title: 'Casa maravilhosa em Ubatuba', property_type: 'casa',
              description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Ubatuba',
              rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
              total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
              daily_rate: '300', owner: owner1)

    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Meus imóveis'

    expect(page).to have_content 'Casa maravilhosa em Ubatuba'
    expect(page).to have_content 'R$ 300,00'
    expect(page).to have_content 'Acomoda 8 pessoas'
    expect(page).to have_content 'Ubatuba'
    
  end
end
