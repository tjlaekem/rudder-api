# frozen_string_literal: true

require('MailchimpMarketing')

module EmailMarketing
  def self.subscribe(email)
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({
                           api_key: ENV['MAILCHIMP_API_KEY'],
                           server: ENV['MAILCHIMP_SERVER']
                         })
    begin
      mailchimp.lists.add_list_member(
        ENV['MAILCHIMP_WAITING_LIST_AUDIENCE'],
        {
          email_address: email,
          status: 'pending'
        }
      )
    rescue MailchimpMarketing::ApiError
      raise(SubscriptionError)
    end
  end

  class SubscriptionError < StandardError
  end
end
