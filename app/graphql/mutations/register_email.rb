# frozen_string_literal: true

require 'digest'
require 'MailchimpMarketing'

module Mutations
  class RegisterEmail < BaseMutation
    argument :email, String, required: true

    type String

    def resolve(email: nil)
      mailchimp = MailchimpMarketing::Client.new
      mailchimp.set_config({
        :api_key => ENV['MAILCHIMP_API_KEY'],
        :server => ENV['MAILCHIMP_SERVER'],
      })
      begin
        response = mailchimp.lists.add_list_member(
          ENV['MAILCHIMP_WAITING_LIST_AUDIENCE'],
          {
            email_address: email,
            status: 'pending',
          }
        )
      rescue MailchimpMarketing::ApiError => error
        raise GraphQL::ExecutionError, "Could not add '#{email}' to waiting list"
      end
      "Added '#{email}' to waiting list"
    end
  end
end
