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
    expect(page).to have_css('p', text: 100.50)
    expect(page).to have_css('p', text: 10)
    expect(page).to have_css('p', text: 'Mongagua')

    expect(page).not_to have_css('h3', text: 'Não encontramos nenhum imóvel cadastrado')
  end

  scenario 'and dont find any property' do
    visit root_path

    expect(page).to have_css('h3', text: 'Não encontramos nenhum imóvel cadastrado')
  end

  def create_prop(title)
    Property.create(title: title,
      maximum_guests: 10, minimum_rent: 3, maximum_rent: 12, daily_rate: 100.50,
      property_location: 'Mongagua')
  end
end
