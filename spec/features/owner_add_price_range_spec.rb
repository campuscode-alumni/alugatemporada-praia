require 'rails_helper'

feature 'Owner add price range' do
  scenario 'successfully' do
    #criar os dados
    location = "Maresias"
    property = Property.create(title: "Casa em Maresias - Pé na areia", maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
                          daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias")

    #navegação
    visit root_path

    click_on 'Meus imóveis'
    click_on property.title

    click_on 'Cadastrar preço'
    fill_in 'Data início: ', with: '2019-02-13'
    fill_in 'Data fim: ', with: '2019-02-16'
    fill_in 'Nome da temporada: ', with: 'Carnaval'
    fill_in 'Preço base/ dia da temporada: ', with: '750.0'
    click_on 'Cadastrar'

    #expectativa
    expect(current_path).to eq(property_path)
    expect(page).to have_css('li', text: 'Carnaval')
    expect(page).to have_css('li', text: '750.0')
    expect(page).to have_css('p', text: 'Temporada cadastrada com sucesso!')
  end
end
