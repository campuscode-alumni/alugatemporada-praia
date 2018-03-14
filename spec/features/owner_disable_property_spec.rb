require 'rails_helper'

feature 'Owner disable a property' do
  scenario 'successfully' do
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Maresias', rent_purpose: 'férias',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
      maximum_rent: '30', daily_rate: '300.00', owner: owner1)

    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar indisponibilidade'

    fill_in 'Descrição', with: 'Férias na praia'
    fill_in 'Data inicial', with: '05/05/2018'
    fill_in 'Data final', with: '15/05/2018'

    click_on 'Salvar'

    expect(current_path).to eq(property_path(property))
    expect(page).to have_css('h3', text: 'Período indisponível')
    expect(page).to have_css('p', text: '05/05/2018')
    expect(page).to have_css('p', text: '15/05/2018')
    expect(page).to have_css('p', text: 'Motivo: Férias na praia')

  end

  scenario 'and must fill all fields' do
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Maresias', rent_purpose: 'férias',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
      maximum_rent: '30', daily_rate: '300.00', owner: owner1)

    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Meus imóveis'

    click_on property.title

    click_on 'Cadastrar indisponibilidade'

    fill_in 'Descrição', with: ''
    fill_in 'Data inicial', with: ''
    fill_in 'Data final', with: ''

    click_on 'Salvar'

    expect(page).to have_css('h3', text: 'Ops algo está errado.')
  end

  scenario 'and date range is unique' do
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Maresias', rent_purpose: 'férias',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
      maximum_rent: '30', daily_rate: '300.00', owner: owner1)

    UnavailableRange.create(description: 'Carnaval', start_date:'01/02/2018',
       end_date:'06/02/2018', property: property)

    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Meus imóveis'

    click_on property.title

    click_on 'Cadastrar indisponibilidade'

    fill_in 'Descrição', with: 'Carnaval'
    fill_in 'Data inicial', with: '05/02/2018'
    fill_in 'Data final', with: '10/02/2018'

    click_on 'Salvar'

    expect(page).to have_css('p', text: 'Este período já está cadastrado')
  end

  scenario 'and date range is unique' do
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Maresias', rent_purpose: 'férias',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
      maximum_rent: '30', daily_rate: '300.00', owner: owner1)

    UnavailableRange.create(description: 'Carnaval', start_date:'01/02/2018',
       end_date:'06/02/2018', property: property)

    visit root_path
    click_on 'Área do proprietário'
    fill_in 'E-mail', with: 'proprietario@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Meus imóveis'

    click_on property.title

    click_on 'Cadastrar indisponibilidade'

    fill_in 'Descrição', with: 'Carnaval'
    fill_in 'Data inicial', with: '30/01/2018'
    fill_in 'Data final', with: '03/02/2018'

    click_on 'Salvar'

    expect(page).to have_css('p', text: 'Este período já está cadastrado')
  end
end
