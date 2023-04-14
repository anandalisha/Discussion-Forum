FactoryBot.define do
    factory :reply do
    
        reply { 'njikodijed' }
        discussion_id { Faker::Base.numerify('#') }   
        user_id { Faker::Base.numerify('#') }  
    end
end