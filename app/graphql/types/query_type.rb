# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :goals, [GoalType], null: false
    def goals
      Goal.all
    end
  end
end
