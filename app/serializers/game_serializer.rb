class GameSerializer < ActiveModel::Serializer
  attributes :name, :status, :user_id

  has_many :squares
end
