# frozen_string_literal: true

module Mutations
  class DeleteSprints < BaseMutation
    argument :sprints, [ID], required: true

    type [ID]

    def resolve(sprints: nil)
      sprints.each do |sprint_id|
        begin
          sprint = Sprint.find(sprint_id)
        rescue StandardError
          raise(GraphQL::ExecutionError, "Sprint '#{sprint_id}' not found")
        end
        sprint.destroy
      end
      sprints
    end
  end
end
