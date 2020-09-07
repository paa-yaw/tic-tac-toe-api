class Square < ApplicationRecord
  belongs_to :user

  validates :position, presence: true
end
