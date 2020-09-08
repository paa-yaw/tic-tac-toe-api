class SquareSerializer < ActiveModel::Serializer
  attributes :position, :value, :user_id, :game_id
end
