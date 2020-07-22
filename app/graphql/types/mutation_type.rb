# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_sprint, mutation: Mutations::CreateSprint
    field :create_goal, mutation: Mutations::CreateGoal
  end
end
