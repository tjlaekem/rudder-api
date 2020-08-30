# frozen_string_literal: true

module Mutations
  class DeleteGoal < BaseMutation
    argument :sprint_id, ID, required: true
    argument :goal_id, ID, required: true

    type Types::SprintType

    def resolve(sprint_id: nil, goal_id: nil)
      begin
        sprint = Sprint.find(sprint_id)
        raise(StandardError) unless sprint.authorized_users.include?(context[:user])
      rescue StandardError
        raise(GraphQL::ExecutionError, "Sprint '#{sprint_id}' not found")
      end
      goals_to_remove = sprint.goals.select { |goal| goal.id.to_str == goal_id }
      raise(GraphQL::ExecutionError, "Goal '#{goal_id}' not found on sprint '#{sprint_id}'") if goals_to_remove.empty?

      sprint.goals = sprint.goals - goals_to_remove
      sprint.save!
      sprint
    end
  end
end
