FactoryBot.define do
    factory :post do
        content { FFaker::Name.name }
        association :user, factory: :user
    end
end