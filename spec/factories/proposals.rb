FactoryBot.define do
  factory :proposal do
    name "MyString"
    email "MyString"
    phone "MyString"
    rent_purpose "MyString"
    maximum_guests 1
    start_date "2018-03-08 20:26:10"
    end_date "2018-03-08 20:26:10"
    petfriendly false
    smoking_allowed false
    proposal_details "MyText"
  end
end
