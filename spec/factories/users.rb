FactoryBot.define do
  factory :user do
    email { 'alice@alice.com' }
    nickname { 'alice' }
    password { '123456' }
  end
end