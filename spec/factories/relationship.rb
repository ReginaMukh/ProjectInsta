FactoryBot.define do
    factory :relationship do
        association :user, factory: :user
    end
end

