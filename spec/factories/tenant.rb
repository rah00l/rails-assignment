FactoryGirl.define do
  factory :tenant do
    name { FFaker::Lorem.word }
  end
end
