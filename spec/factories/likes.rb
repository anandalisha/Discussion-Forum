FactoryBot.define do
    factory :like do
        user_id { Faker::Base.numerify('#') }
        for_discussion
        trait :for_discussion do
            association :likeable, factory: :discussion
        end

        trait :for_reply do
            association :likeable, factory: :reply
        end

    end
end