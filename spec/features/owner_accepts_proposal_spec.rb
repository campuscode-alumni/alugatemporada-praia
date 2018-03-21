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

  scenario 'and rejects all other proposals' do
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

    expect(page).to have_css("div#proposal-#{proposal1.id}", text: 'rejeitada')

    within("div#proposal-#{proposal2.id}") do
      expect(page).to have_content('aceita')
    end
    #expect("div#proposal-#{proposal1.id}").to be_rejected
  end

  scenario 'and keeps as pending the proposals with same date range ' do
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
        start_date: '2018-12-22', end_date: '2018-12-28', petfriendly: true,
        smoking_allowed: true, proposal_details: 'Bla bla bla')

      proposal2 = Proposal.create!(property: property, user: user,
        email: user.email, phone: user.phone,
        rent_purpose: 'Ano novo com os amigos', maximum_guests: '6',
        start_date: '2018-12-27', end_date: '2019-01-10', petfriendly: true,
        smoking_allowed: true, proposal_details: 'Bla bla bla etc etc')

      proposal3 = Proposal.create!(property: property, user: user,
        email: user.email, phone: user.phone,
        rent_purpose: 'Ano novo com os amigos', maximum_guests: '6',
        start_date: '2018-12-20', end_date: '2019-01-12', petfriendly: true,
        smoking_allowed: true, proposal_details: 'Bla bla bla etc etc')

      proposal4 = Proposal.create!(property: property, user: user,
        email: user.email, phone: user.phone,
        rent_purpose: 'Ano novo com os amigos', maximum_guests: '6',
        start_date: '2019-01-15', end_date: '2019-01-30', petfriendly: true,
        smoking_allowed: true, proposal_details: 'Bla bla bla etc etc')

      proposal5 = Proposal.create!(property: property, user: user,
        email: user.email, phone: user.phone,
        rent_purpose: 'Ano novo com os amigos', maximum_guests: '6',
        start_date: '2018-12-28', end_date: '2019-01-09', petfriendly: true,
        smoking_allowed: true, proposal_details: 'Bla bla bla etc etc')

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

      expect(page).to have_css("div#proposal-#{proposal1.id}", text: 'rejeitada')
      expect(page).to have_css("div#proposal-#{proposal2.id}", text: 'aceita')
      expect(page).to have_css("div#proposal-#{proposal3.id}", text: 'rejeitada')
      expect(page).to have_css("div#proposal-#{proposal4.id}", text: 'pendente')
      expect(page).to have_css("div#proposal-#{proposal5.id}", text: 'rejeitada')

  end

end
