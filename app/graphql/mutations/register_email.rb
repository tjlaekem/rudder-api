# frozen_string_literal: true

require("#{Rails.root}/lib/email_marketing")

module Mutations
  class RegisterEmail < BaseMutation
    argument :email, String, required: true

    type String

    def resolve(email: nil)
      begin
        EmailMarketing.subscribe(email)
      rescue EmailMarketing::SubscriptionError
        raise(GraphQL::ExecutionError, "Could not add '#{email}' to waiting list")
      end
      "Added '#{email}' to waiting list"
    end
  end
end
