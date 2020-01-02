FactoryBot.define do

  factory :tweet do
    text    {Faker::Lorem.sentence}
    user
  end
  
end