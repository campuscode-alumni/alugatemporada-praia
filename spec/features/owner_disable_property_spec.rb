require 'rails_helper'

feature 'Owner disable a property' do
  scenario 'successfully' do
    property = Property.create(title: "Casa em Maresias - Pé na areia",
      property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi',
      property_location: 'Maresias', rent_purpose: 'férias',
      accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5',
      maximum_rent: '30', daily_rate: '300.00')

    visit root_path

    click_on property.title

    click_on 'Cadastrar indisponíbilidade'

    fill_in 'Descrição', with: 'Férias na praia'
    fill_in 'Data inicial', with: '05/05/2018'
    fill_in 'Data final', with: '15/05/2018'

    click_on 'Salvar'

    expect(page).to have_css('h3', 'Período indisponível:')
    expect(page).to have_css('p', '05/05/2018')
    expect(page).to have_css('p', '15/05/2018')
    expect(page).to have_css('p', 'Motivo: Férias na praia')

  end
end
