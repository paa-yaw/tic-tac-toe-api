FactoryBot.define do
  factory :game do
    duration { 1 }
    sequence :name do 
      |n| "Game #{n}"
    end
    status { 'in-progress' }
  end
end
