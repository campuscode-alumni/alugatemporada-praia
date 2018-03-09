require 'rails_helper'

feature 'user send proposal' do
  scenario 'open form' do
    property = Property.create(title: 'Casa charmosa em Ubatuba', property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi', location: 'Ubatuba',
            rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
            daily_rate: '300.00')

    visit root_path
    click_on property.title
    click_on 'Envie uma proposta'

    fill_in 'Nome:', with: 'Maria Aparecida da Silva'
    fill_in 'E-mail:', with: 'mariadasilva@email.abc'
    fill_in 'Telefone:', with: '11-987654321'
    fill_in 'Finalidade:', with: 'Feriado e final de semana'
    fill_in 'Quantidade de hóspedes:', with: '5 pessoas'
    fill_in 'Data de entrada:', with: '29/04/2018'
    fill_in 'Data de saída:', with: '02/05/2018'
    check 'Pretendo levar pets'
    uncheck 'Fumantes'
    fill_in 'Outras informações:', with: 'Procuro casa próxima à praia'

    click_on 'Enviar proposta'

    expect(current_path).to eq(property_path(property))
  end

  scenario 'all fields are required' do
    property = Property.create(title: 'Casa charmosa em Ubatuba', property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi', location: 'Ubatuba',
            rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
            daily_rate: '300.00')

    visit root_path
    click_on property.title
    click_on 'Envie uma proposta'

    fill_in 'Nome:', with: ''
    fill_in 'E-mail:', with: ''
    fill_in 'Telefone:', with: ''
    fill_in 'Finalidade:', with: ''
    fill_in 'Quantidade de hóspedes:', with: ''
    fill_in 'Data de entrada:', with: ''
    fill_in 'Data de saída:', with: ''
    check 'Pretendo levar pets'
    uncheck 'Fumantes'
    fill_in 'Outras informações:', with: 'Procuro casa próxima à praia'

    click_on 'Enviar proposta'

    expect(page).to have_content('Você deve preencher todos os campos para enviar uma proposta') 
  end

end
