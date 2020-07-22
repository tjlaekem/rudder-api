# frozen_string_literal: true

module Mutations
  class CreateSprint < BaseMutation
    argument :end_date, GraphQL::Types::ISO8601Date, required: true

    type Types::SprintType

    def resolve(end_date: nil)
      Sprint.create!(
        end_date: end_date
      )
    end
  end
end
