FactoryGirl.define do
  factory :channel do
    name { FFaker::BaconIpsum.characters(50) }
    status 0
    description { FFaker::BaconIpsum.characters(255) }
    author_id 1
  end
end
