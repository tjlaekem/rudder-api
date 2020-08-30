# frozen_string_literal: true

module Mutations
  class DeleteSprint < BaseMutation
    argument :sprint_id, ID, required: true

    type String

    def resolve(sprint_id: nil)
      begin
        sprint = Sprint.find(sprint_id)
      rescue StandardError
        raise(GraphQL::ExecutionError, "Sprint '#{sprint_id}' not found")
      end
      sprint.destroy
      'success'
    end
  end
end
