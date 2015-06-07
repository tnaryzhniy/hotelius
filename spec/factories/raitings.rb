FactoryGirl.define do

  factory :raiting do
    sequence(:raiting) { (1 + rand(5)) }
    sequence(:comment) { |i|  "comment #{i}" }
    commenter 'taras@taras.taras'
  end
end
