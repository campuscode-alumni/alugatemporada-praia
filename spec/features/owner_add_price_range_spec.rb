require 'rails_helper'

feature 'Owner add price range' do
  scenario 'successfully' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')
    property = Property.create!(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

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

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "13/02/2019"
    fill_in 'Data fim', with: "16/02/2019"
    fill_in 'Nome da temporada', with: 'Carnaval'
    fill_in 'Preço base/ dia da temporada', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(current_path).to eq(property_path(property.id))
    expect(page).to have_css('h4', text: 'Carnaval')
    expect(page).to have_css('li', text: '750,00')
    expect(page).to have_css('li', text: "13/02/2019")
    expect(page).to have_css('li', text: "16/02/2019")
    expect(page).to have_css('p', text: 'Temporada cadastrada com sucesso!')
  end

  scenario 'and must fill all fields' do
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

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

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: ''
    fill_in 'Data fim', with: ''
    fill_in 'Nome da temporada', with: ''
    fill_in 'Preço base/ dia da temporada', with: ''
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_css('p', text: 'Todos os campos devem ser preenchidos')
  end

  scenario 'and dont allow add other date that conflict with end_date' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

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

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "2019-02-15"
    fill_in 'Data fim', with: "2019-02-20"
    fill_in 'Nome da temporada', with: 'Feriado prolongado'
    fill_in 'Preço base/ dia da temporada', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data informada já consta cadastrada em outra temporada")
  end

  scenario 'and dont allow add other date that conflict with start_date' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida',
      email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    #navegação
    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: owner1.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "2019-02-11"
    fill_in 'Data fim', with: "2019-02-15"
    fill_in 'Nome da temporada', with: 'Feriado prolongado'
    fill_in 'Preço base/ dia da temporada', with: '450.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data informada já consta cadastrada em outra temporada")
  end

  scenario 'and dont allow add inside other range' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida',
      email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    #navegação
    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: owner1.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "2019-02-14"
    fill_in 'Data fim', with: "2019-02-15"
    fill_in 'Nome da temporada', with: 'Sexta Feira Santa'
    fill_in 'Preço base/ dia da temporada', with: '350.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data informada já consta cadastrada em outra temporada")
  end

  scenario 'and dont allow add a range that contains other' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida',
      email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    #navegação
    visit root_path
    click_on 'Área do proprietário'
    within('form') do
      fill_in 'E-mail', with: owner1.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início', with: "2019-02-10"
    fill_in 'Data fim', with: "2019-02-20"
    fill_in 'Nome da temporada', with: 'Carnaval'
    fill_in 'Preço base/ dia da temporada', with: '350.0'
    click_on 'Cadastrar'

    #expectativa
    expect(page).to have_content("A data informada já consta cadastrada em outra temporada")
  end

  scenario 'and dont allow end_date be smaller than start_date' do
    #criar os dados
    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

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
