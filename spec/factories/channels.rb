FactoryBot.define do
    factory :channel do
    
        channel { 'hbhirfk' }
        discussion_id { Faker::Base.numerify('#') }    
    end
end