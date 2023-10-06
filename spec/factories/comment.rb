FactoryBot.define do
    factory :comment do
        body { FFaker::Name.name }
        association :user, factory: :user
        association :post, factory: :post
    end
end