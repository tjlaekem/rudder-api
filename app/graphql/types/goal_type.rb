# frozen_string_literal: true

module Types
  class GoalType < Types::BaseObject
    field :id, ID, null: false
    field :text, String, null: false
    field :isAchieved, Boolean, null: false
  end
end
