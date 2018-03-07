require 'rails_helper'

feature 'Visitor list properties by location' do
  scenario 'successfully' do
    #criar os dados
    location = "Maresias"
    property = Property.create(title: "Casa em Maresias - Pé na areia", maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
                          daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias")

    other_property = Property.create(title: "Casa em Maresias c/ piscina", maximum_guests: 8, minimum_rent: 2, maximum_rent: 20,
                          daily_rate: 250, rent_purpose: "Lazer", property_location: "Maresias")

    #navegação
    visit root_path
    select 'Maresias', from: "Localização"
    click_on "Buscar"

    #expectativa

    expect(page).to have_css("h1", text: "Resultados de imóveis em #{location}")


    expect(page).to have_css("div.property-img img")
    expect(page).to have_css("div.property-details h3", text: property.title)
    expect(page).to have_css("div.property-details li", text: property.daily_rate)
    expect(page).to have_css("div.property-details li", text: property.maximum_guests)

    expect(page).to have_css("div.property-img img")
    expect(page).to have_css("div.property-details h3", text: other_property.title)
    expect(page).to have_css("div.property-details li", text: other_property.daily_rate)
    expect(page).to have_css("div.property-details li", text: other_property.maximum_guests)
  end

  scenario "and dont show property of other location" do
    #criar os dados
    location = "Maresias"
    property = Property.create(title: "Casa em Maresias - Pé na areia", maximum_guests: 10, minimum_rent: 2, maximum_rent: 30,
                          daily_rate: 450, rent_purpose: "Lazer", property_location: "Maresias")

    other_property = Property.create(title: "Casa em Santos c/ piscina", maximum_guests: 8, minimum_rent: 2, maximum_rent: 20,
                          daily_rate: 250, rent_purpose: "Lazer", property_location: "Santos")

    #navegação
    visit root_path
    select location, from: "Localização"
    click_on "Buscar"

    #expectativa
    expect(page).to have_css("h3", text: "#{property.title}")
    expect(page).not_to have_css("h3", text: "#{other_property.title}")
  end
end
