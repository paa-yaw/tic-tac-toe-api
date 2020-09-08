FactoryBot.define do
  factory :square do
    sequence :position do |n|
      n
    end
    value { nil }
    user_id { nil }
    game { nil }
  end
end
