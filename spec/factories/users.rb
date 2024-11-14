FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_user#{n}@test.com" }
    sequence(:name) { |n| "foo#{n} bar#{n}" }
  end
end
