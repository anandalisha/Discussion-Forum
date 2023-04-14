FactoryBot.define do
    factory :discussion do
    title { Faker::Movie.title }
    content { Faker::Hipster.sentences.sample }
    #channel_id { Faker::Base.numerify('#') }
    channel 
    user_id { Faker::Base.numerify('#') }
    end
end