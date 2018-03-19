require 'rails_helper'

feature 'show last 10 Properties' do
  scenario 'successfully' do

    apartamento = create_prop('Apartamento na praia de Jurerê')
    casa = create_prop('Casa na praia de pipa')
    create_prop('Casa no campo')
    create_prop('Apartamento no Rio de Janeiro')
    create_prop('Casa em ilha Bela')
    create_prop('Casa em São Sebastião')
    create_prop('Rio Grande Do norte')
    create_prop('Ap no Interior')
    create_prop('Casa em Florianópolis')
    create_prop('Praia Grande')
    create_prop('Apartamento em Ubatuba')
    create_prop('Casa na praia')

    visit root_path

    expect(page).to have_css('h3', text: 'Casa na praia')
    expect(page).to have_css('h3', text: 'Apartamento em Ubatuba')
    expect(page).to have_css('h3', text: 'Praia Grande')
    expect(page).to have_css('h3', text: 'Casa em Florianópolis')
    expect(page).to have_css('h3', text: 'Ap no Interior')
    expect(page).to have_css('h3', text: 'Rio Grande Do norte')
    expect(page).to have_css('h3', text: 'Casa em São Sebastião')
    expect(page).to have_css('h3', text: 'Casa em ilha Bela')
    expect(page).to have_css('h3', text: 'Apartamento no Rio de Janeiro')
    expect(page).to have_css('h3', text: 'Casa no campo')

    expect(page).not_to have_css('h3', text: casa.title)
    expect(page).not_to have_css('h3', text: apartamento.title)
  end

  scenario 'and see a short description of one property' do
    create_prop('Casa no campo')

    visit root_path

    expect(page).to have_css('h3', text: 'Casa no campo')
    expect(page).to have_css('p', text: '300,00 por dia')
    expect(page).to have_css('p', text: 'Acomoda no máximo 8 pessoas')
    expect(page).to have_css('p', text: 'Ubatuba')

    expect(page).not_to have_css('h3', text: 'Não encontramos nenhum imóvel cadastrado')
  end

  scenario 'and dont find any property' do
    visit root_path

    expect(page).to have_css('h3', text: 'Não encontramos nenhum imóvel cadastrado')
  end

  def create_prop(title)
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    Property.create(title: title, property_type: 'casa',
              description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Ubatuba',
              rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
              total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
              daily_rate: '300.00', owner: owner1)
  end
end
