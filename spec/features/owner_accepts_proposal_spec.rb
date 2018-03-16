require 'rails_helper'

feature 'owner accepts proposal' do
  scenario 'successfully' do
    #criar os dados
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')

    user = User.create(name: 'Joao Almeida', email: 'joao.almeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create!(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    proposal = Proposal.create!(property: property, user: user,
      email: user.email, phone: user.phone,
      rent_purpose: 'Feriado com os amigos', maximum_guests: '6',
      start_date: '2019-12-30', end_date: '2020-01-06', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla')

    #navegação
    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    click_on 'Meus imóveis'
    click_on property.title
    click_on 'Aceitar proposta'

    expect(page).to have_css('p', text: 'Proposta aprovada')
  end
end
