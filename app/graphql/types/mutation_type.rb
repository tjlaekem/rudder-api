# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_goal, mutation: Mutations::CreateGoal
    field :create_sprint, mutation: Mutations::CreateSprint
    field :register_email, mutation: Mutations::RegisterEmail
  end
end
