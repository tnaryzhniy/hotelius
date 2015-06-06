FactoryGirl.define do

  factory :hotel do
    sequence(:id) { |i|  1 + i }
    sequence(:title) { |i|  "Hotel#{i}" }
    stars 1
    breakfast false
    rooms 'Room description'
    foto 'MyString'
    price 10
    user
    sequence(:aver_raiting) { |i|  0.5 + i }
    address
  end
end
