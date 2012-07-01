FactoryGirl.define do
  factory :city do
    sequence(:name) { |n| "City #{n}" }
  end

  factory :measure do
    date            DateTime.now
    sequence(:pm25) { |n| n }
    city
  end

end
