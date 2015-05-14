FactoryGirl.define do
  factory :user do
    sequence(:email) { |i|  "taras#{i}@taras.taras" }
    password '0987654321'
  end

end
