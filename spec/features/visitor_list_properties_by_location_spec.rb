require 'rails_helper'

feature 'Visitor list properties by location' do
  scenario 'successfully' do
    #criar os dados
    location = "Maresias"
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    owner2 = Owner.create(email: 'proprietario2@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia", property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Maresias',
      rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
      daily_rate: '300.00', owner: owner1)

    other_property = Property.create(title: "Casa em Maresias c/ piscina", property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Maresias',
      rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
      daily_rate: '300.00', owner: owner2)

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
    owner1 = Owner.create(email: 'proprietario@email.com', password: '123456')
    owner2 = Owner.create(email: 'proprietario2@email.com', password: '123456')
    property = Property.create(title: "Casa em Maresias - Pé na areia", property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Maresias',
      rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
      daily_rate: '300.00', owner: owner1)

    other_property = Property.create(title: "Casa em Maresias c/ piscina", property_type: 'casa',
      description: 'Casa nova, com quartos climatizados e wi-fi', property_location: 'Santos',
      rent_purpose: 'férias', accessibility: true, petfriendly: true, smoking_allowed: false,
      total_rooms: '2', maximum_guests: '8', minimum_rent: '5', maximum_rent: '30',
      daily_rate: '300.00', owner: owner2)

    #navegação
    visit root_path
    select location, from: "Localização"
    click_on "Buscar"

    #expectativa
    expect(page).to have_css("h3", text: "#{property.title}")
    expect(page).not_to have_css("h3", text: "#{other_property.title}")
  end
end
