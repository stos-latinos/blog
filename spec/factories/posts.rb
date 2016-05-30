FactoryGirl.define do
  factory :post do
    association :user, factory: :user
    title 'first post'
    text 'post text'
    author_ip '192.168.0.5'
  end
end