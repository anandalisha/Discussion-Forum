FactoryBot.define do
    factory :user do
    email { Faker::Internet.email }
    encrypted_password { Faker::Internet.password(min_length: 6) }
    username { Faker::Internet.username }
    end
end