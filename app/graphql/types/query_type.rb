# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :sprints, [SprintType], null: false, scope: true
    def sprints
      Sprint.order_by(end_date: :desc)
    end

    field :sprint, SprintType, null: false do
      argument :id, ID, required: true
    end
    def sprint(id:)
      sprint = Sprint.find(id)
      raise(StandardError) unless sprint.authorized_users.include?(context[:user])

      sprint
    rescue StandardError
      raise(GraphQL::ExecutionError, "Sprint '#{id}' not found")
    end
  end
end
