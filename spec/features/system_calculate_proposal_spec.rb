require 'rails_helper'

feature 'Calculate proposal' do
  scenario 'successfully' do
    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
      password: '123456', phone: '+5511912345678')

    property = Property.create!(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
      daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias",
      description: 'Casa nova, com quartos climatizados e wi-fi',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', owner: owner1)

    price_range = PriceRange.create(description: "Carnaval",
      start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
      property: property)

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on property.title
    click_on 'Envie uma proposta'
    fill_in 'Telefone:', with: '11-987654321'
    fill_in 'Finalidade:', with: 'Feriado e final de semana'
    fill_in 'Quantidade de hóspedes:', with: '5 pessoas'
    fill_in 'Data de entrada:', with: '13/02/2019'
    fill_in 'Data de saída:', with: '16/02/2019'
    check 'Pretendo levar pets'
    uncheck 'Fumantes'
    fill_in 'Outras informações:', with: 'Procuro casa próxima à praia'

    click_on 'Enviar proposta'

    visit root_path
    click_on 'Minhas propostas'

    expect(page).to have_css('li', text: 'Feriado e final de semana')
    expect(page).to have_css('li', text: 'R$ 4000,00')
    expect(page).to have_css('li', text: '13/02/2019')
    expect(page).to have_css('li', text: '16/02/2019')

    end
    scenario 'out of range' do
      user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
        phone: '+5511912345678')

      owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
        password: '123456', phone: '+5511912345678')

      property = Property.create!(title: "Casa em Maresias - Pé na areia",
        property_type: 'casa',
        maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
        daily_rate: 300, rent_purpose: "Lazer", property_location: "Maresias",
        description: 'Casa nova, com quartos climatizados e wi-fi',
        accessibility: true, petfriendly: true, smoking_allowed: false,
        total_rooms: '2', owner: owner1)

      price_range = PriceRange.create(description: "Carnaval",
        start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
        property: property)

      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
      click_on property.title
      click_on 'Envie uma proposta'
      fill_in 'Telefone:', with: '11-987654321'
      fill_in 'Finalidade:', with: 'Feriado e final de semana'
      fill_in 'Quantidade de hóspedes:', with: '5 pessoas'
      fill_in 'Data de entrada:', with: '20/02/2019'
      fill_in 'Data de saída:', with: '22/02/2019'
      check 'Pretendo levar pets'
      uncheck 'Fumantes'
      fill_in 'Outras informações:', with: 'Procuro casa próxima à praia'

      click_on 'Enviar proposta'

      visit root_path
      click_on 'Minhas propostas'

      expect(page).to have_css('li', text: 'Feriado e final de semana')
      expect(page).to have_css('li', text: 'R$ 900,00')
      expect(page).to have_css('li', text: '20/02/2019')
      expect(page).to have_css('li', text: '22/02/2019')

      end

      scenario 'with one day in range' do
        user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
          phone: '+5511912345678')

        owner1 = Owner.create(name: 'Joao Almeida', email: 'proprietario@email.com',
          password: '123456', phone: '+5511912345678')

        property = Property.create!(title: "Casa em Maresias - Pé na areia",
          property_type: 'casa',
          maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
          daily_rate: 300, rent_purpose: "Lazer", property_location: "Maresias",
          description: 'Casa nova, com quartos climatizados e wi-fi',
          accessibility: true, petfriendly: true, smoking_allowed: false,
          total_rooms: '2', owner: owner1)

        price_range = PriceRange.create(description: "Carnaval",
          start_date: "13/02/2019", end_date: "16/02/2019", daily_rate: 1000,
          property: property)

        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Entrar'
        click_on property.title
        click_on 'Envie uma proposta'
        fill_in 'Telefone:', with: '11-987654321'
        fill_in 'Finalidade:', with: 'Feriado e final de semana'
        fill_in 'Quantidade de hóspedes:', with: '5 pessoas'
        fill_in 'Data de entrada:', with: '10/02/2019'
        fill_in 'Data de saída:', with: '13/02/2019'
        check 'Pretendo levar pets'
        uncheck 'Fumantes'
        fill_in 'Outras informações:', with: 'Procuro casa próxima à praia'

        click_on 'Enviar proposta'

        visit root_path
        click_on 'Minhas propostas'

        expect(page).to have_css('li', text: 'Feriado e final de semana')
        expect(page).to have_css('li', text: 'R$ 1900,00')
        expect(page).to have_css('li', text: '10/02/2019')
        expect(page).to have_css('li', text: '13/02/2019')

        end
end
