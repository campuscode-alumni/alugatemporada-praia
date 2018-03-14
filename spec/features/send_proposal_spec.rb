require 'rails_helper'

feature 'user send proposal' do
  scenario 'open form' do

    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')

    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba', property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Ubatuba',
            rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
            daily_rate: '300.00', owner: owner1)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on property.title
    click_on 'Envie uma proposta'
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
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')

    user = User.create(name: 'Joao Almeida', email: 'joaoalmeida@campuscode.com.br', password: '123456',
      phone: '+5511912345678')

    property = Property.create(title: 'Casa charmosa em Ubatuba', property_type: 'casa',
            description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Ubatuba',
            rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
            total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
            daily_rate: '300.00', owner: owner1)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on property.title
    click_on 'Envie uma proposta'

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
