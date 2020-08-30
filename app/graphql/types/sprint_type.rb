# frozen_string_literal: true

module Types
  class SprintType < Types::BaseObject
    field :authorized_users, [String], null: false
    field :id, ID, null: false
    field :end_date, GraphQL::Types::ISO8601Date, null: false
    field :goals, [GoalType], null: true

    def self.scope_items(sprints, context)
      sprints.select do |sprint|
        sprint.authorized_users.include?(context[:user])
      end
    end
  end
end
