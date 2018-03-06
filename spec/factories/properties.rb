FactoryBot.define do
  factory :property do
    title "MyString"
    maximum_guests 1
    minimum_rent 1
    maximum_rent 1
    daily_rate "9.99"
    rent_purpose "MyString"
    property_location "MyString"
  end
end
