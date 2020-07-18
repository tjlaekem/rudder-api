# frozen_string_literal: true

module Mutations
  class CreateGoal < BaseMutation
    argument :text, String, required: true
    argument :is_achieved, Boolean, required: true

    type Types::GoalType

    def resolve(text: nil, is_achieved: nil)
      Goal.create!(
        text: text,
        is_achieved: is_achieved
      )
    end
  end
end
