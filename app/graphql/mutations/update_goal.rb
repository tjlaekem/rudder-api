# frozen_string_literal: true

module Mutations
  class UpdateGoal < BaseMutation
    argument :sprint_id, ID, required: true
    argument :goal_id, ID, required: true
    argument :text, String, required: false
    argument :is_achieved, Boolean, required: false

    type Types::SprintType

    def resolve(sprint_id: nil, goal_id: nil, text: nil, is_achieved: nil)
      sprint = Sprint.find(sprint_id)
      goal = nil
      sprint.goals.each do |list_goal|
        goal = list_goal if list_goal.id.to_str == goal_id
      end
      return sprint unless goal

      goal.text = text unless text.nil?
      goal.is_achieved = is_achieved unless is_achieved.nil?
      sprint.save!
      sprint
    end
  end
end
