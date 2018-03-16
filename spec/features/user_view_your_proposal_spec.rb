require 'rails_helper'

feature 'User view your proposals' do
  scenario 'successfully' do
    #Criação dos dados
    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba',
      property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi',
            property_location: 'Ubatuba', rent_purpose: 'férias',
            accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
            maximum_rent: '30', daily_rate: '300.00')

    proposal = Proposal.create(property: property, user_id: user.id,
      email: user.email, phone: user.phone,
      rent_purpose: 'Feriado com os amigos', maximum_guests: '6',
      start_date: '2019-12-30', end_date: '2020-01-01', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla')

    #Navegação
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Minhas propostas'

    #Expectativa
    expect(page).to have_css('h4', text: proposal.property.title)
    expect(page).to have_css('li', text: proposal.rent_purpose)
    expect(page).to have_css('li', text: '30/12/2019')
    expect(page).to have_css('li', text: '01/01/2020')
  end

  scenario 'and view more details' do
    #Criação dos dados
    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba',
      property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi',
            property_location: 'Ubatuba', rent_purpose: 'férias',
            accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
            maximum_rent: '30', daily_rate: '300.00')

    proposal = Proposal.create(property: property, user_id: user.id,
      email: user.email, phone: user.phone,
      rent_purpose: 'Feriado com os amigos', maximum_guests: '6',
      start_date: '2019-12-30', end_date: '2020-01-01', petfriendly: true,
      smoking_allowed: true, proposal_details: 'Bla bla bla')

    #Navegação
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Minhas propostas'
    click_on proposal.property.title

    #Expectativa
    expect(page).to have_css('h3', text: "Proposta ##{proposal.property.id}")
    expect(page).to have_css('h5', text: proposal.property.title)
    expect(page).to have_css('li', text: proposal.user.name)
    expect(page).to have_css('li', text: proposal.email)
    expect(page).to have_css('li', text: proposal.phone)
    expect(page).to have_css('li', text: proposal.rent_purpose)
    expect(page).to have_css('li', text: proposal.start_date)
    expect(page).to have_css('li', text: proposal.end_date)
    expect(page).to have_css('li', text: proposal.maximum_guests)
    expect(page).to have_css('li', text: "Possui fumantes? Sim")
    expect(page).to have_css('li', text: "Possui animais? Sim")
    expect(page).to have_css('p' , text: proposal.proposal_details)
  end

  scenario "and view message if haven't none" do
    #Criação dos dados
    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba',
      property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi',
            property_location: 'Ubatuba', rent_purpose: 'férias',
            accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
            maximum_rent: '30', daily_rate: '300.00')

    #Navegação
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Minhas propostas'

    #Expectativa
    expect(page).to have_content('Você ainda não possui propostas.')
  end
end
