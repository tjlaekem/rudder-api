# frozen_string_literal: true

module Mutations
  class CreateGoal < BaseMutation
    argument :sprint_id, ID, required: true
    argument :text, String, required: true

    type Types::SprintType

    def resolve(sprint_id: nil, text: nil)
      begin
        sprint = Sprint.find(sprint_id)
        raise(StandardError) unless sprint.authorized_users.include?(context[:user])
      rescue StandardError
        raise(GraphQL::ExecutionError, "Sprint '#{sprint_id}' not found")
      end
      goal = Goal.new(text: text)
      sprint.goals.push(goal)
      sprint
    end
  end
end
