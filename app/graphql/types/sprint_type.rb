# frozen_string_literal: true

module Types
  class SprintType < Types::BaseObject
    field :id, ID, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false
    field :goals, [GoalType], null: true
  end
end
