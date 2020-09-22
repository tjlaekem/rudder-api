# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_goal, mutation: Mutations::CreateGoal
    field :create_sprint, mutation: Mutations::CreateSprint
    field :delete_goal, mutation: Mutations::DeleteGoal
    field :delete_sprint, mutation: Mutations::DeleteSprint
    field :delete_sprints, mutation: Mutations::DeleteSprints
    field :register_email, mutation: Mutations::RegisterEmail
    field :update_goal, mutation: Mutations::UpdateGoal
  end
end
