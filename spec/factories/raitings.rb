FactoryGirl.define do
  factory :raiting do
    raiting 1
    sequence(:comment) { |i|  "comment #{i}" }
    hotel
    user
    commenter 'taras@taras.taras'
  end

end
