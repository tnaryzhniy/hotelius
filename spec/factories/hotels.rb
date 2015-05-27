FactoryGirl.define do
  factory :hotel do
    sequence(:id) { |i|  1 + i }
    title 'Hotel'
    stars 1
    breakfast false
    rooms 'Room description'
    foto 'MyString'
    price 10
    user
    aver_raiting 0
  end

end
