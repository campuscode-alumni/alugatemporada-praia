require 'rails_helper'

feature 'owner accepts proposal' do
  scenario 'successfully' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    user = User.create(name: 'Joao Almeida',
      email: 'joao.almeida@campuscode.com.br', password: '123456',
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
    within('form') do
      fill_in 'E-mail', with: 'proprietario@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Meus imóveis'
    click_on property.title
    click_on 'Aceitar proposta'

    prop = Proposal.last
    expect(prop).to be_accepted
    expect(page).to have_content 'Proposta aceita com sucesso'
  end

  scenario 'and rejects all proposals with same date range'do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    user = User.create(name: 'Joao Almeida',
      email: 'joao.almeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create!(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    proposal1 = Proposal.create!(property: property, user: user,
      email: user.email, phone: user.phone,
      rent_purpose: 'Natal com os amigos', maximum_guests: '6',
      start_date: '2018-12-25', end_date: '2019-01-06', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla')

    proposal2 = Proposal.create!(property: property, user: user,
      email: user.email, phone: user.phone,
      rent_purpose: 'Ano novo com os amigos', maximum_guests: '6',
      start_date: '2018-12-30', end_date: '2019-01-10', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla etc etc')

    proposal3 = Proposal.create!(property: property, user: user,
      email: user.email, phone: user.phone,
      rent_purpose: 'Ferias com os amigos', maximum_guests: '6',
      start_date: '2018-12-24', end_date: '2019-01-05', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla 123 123')

    proposal4 = Proposal.create!(property: property, user: user,
      email: user.email, phone: user.phone,
      rent_purpose: 'Feriado com os amigos', maximum_guests: '6',
      start_date: '2019-01-11', end_date: '2019-01-20', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla abc abc')

#navegação
    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: 'proprietario@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Meus imóveis'
    click_on property.title
    within("div#proposal-#{proposal2.id}") do
      click_on 'Aceitar proposta'
    end
    expect("div#proposal-#{proposal1.id}").to be_rejected
    expect("div#proposal-#{proposal3.id}").to be_rejected


    end

end
