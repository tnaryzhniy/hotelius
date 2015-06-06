FactoryGirl.define do

  factory :raiting do
    # raiting ( 1 + rand(5) )
    sequence(:raiting) { (1 + rand(5)) }
    sequence(:comment) { |i|  "comment #{i}" }
    # hotel
    # user
    commenter 'taras@taras.taras'
  end
end
