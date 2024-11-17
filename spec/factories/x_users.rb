FactoryBot.define do
  factory :x_user do
    transient do
      custom_email { nil }
      custom_name { nil }
    end
    sequence(:email) { |n| custom_email || "test_user#{n}@test.com" }
    sequence(:name) { |n| custom_name || "foo#{n} bar#{n}" }
  end
end
