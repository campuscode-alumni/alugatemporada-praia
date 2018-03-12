require 'rails_helper'

feature 'Owner add price range' do
  scenario 'successfully' do
    #criar os dados
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2')

    #navegação
    visit root_path

    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "13/02/2019"
    fill_in 'Data fim', with: "16/02/2019"
    fill_in 'Nome da temporada', with: 'Carnaval'
    fill_in 'Preço base/ dia da temporada', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(current_path).to eq(property_path(property.id))
    expect(page).to have_css('h4', text: 'Carnaval')
    expect(page).to have_css('li', text: '750.0')
    expect(page).to have_css('li', text: "2019-02-13")
    expect(page).to have_css('li', text: "2019-02-16")
    expect(page).to have_css('p', text: 'Temporada cadastrada com sucesso!')
  end

  scenario 'and must fill all fields' do
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2')

    #navegação
    visit root_path

    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: ''
    fill_in 'Data fim', with: ''
    fill_in 'Nome da temporada', with: ''
    fill_in 'Preço base/ dia da temporada', with: ''
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_css('p', text: 'Todos os campos devem ser preenchidos')
  end

  scenario 'and dont allow add other date in the same range' do
    #criar os dados
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2')

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    #navegação
    visit root_path
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "2019-02-15"
    fill_in 'Data fim', with: "2019-02-20"
    fill_in 'Nome da temporada', with: 'Feriado prolongado'
    fill_in 'Preço base/ dia da temporada', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data informada já consta cadastrada em outra temporada")
  end

  scenario 'and dont allow end_date be smaller than start_date' do
    #criar os dados
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2')

    #navegação
    visit root_path
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "15/02/2019"
    fill_in 'Data fim', with: "14/02/2019"
    fill_in 'Nome da temporada', with: 'Feriado prolongado'
    fill_in 'Preço base/ dia da temporada', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data fim não pode ser menor do que a data início")
  end
end
