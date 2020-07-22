# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :sprints, [SprintType], null: false
    def sprints
      Sprint.all
    end
  end
end
