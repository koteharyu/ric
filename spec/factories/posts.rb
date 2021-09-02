FactoryBot.define do
  factory :post do
    body { Faker::Hacker.say_something_smart }
    user
  end
end
