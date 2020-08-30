# frozen_string_literal: true

require("#{Rails.root}/lib/authentication")

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  before_action :authenticate

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      user: Authentication.get_user(request.headers['Authorization'])
    }
    result = RudderApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render(json: result)
  rescue StandardError => e
    raise(e) unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  def authenticate
    Authentication.authenticate(request.headers['Authorization'])
  rescue Authentication::AuthenticationError
    render(json: { error: 'Authentication failed' }, status: :unauthorized)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise(ArgumentError, "Unexpected parameter: #{ambiguous_param}")
    end
  end

  def handle_error_in_development(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))

    render(json: { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} }, status: 500)
  end
end
