# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :goals, [GoalType], null: false
    def goals
      [{ id: 0, text: 'Get a test goal working', isAchieved: false }]
    end
  end
end
