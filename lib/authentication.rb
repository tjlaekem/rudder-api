# frozen_string_literal: true

require('net/http')
require('uri')

module Authentication
  def self.authenticate(auth_header)
    raise(AuthenticationError) unless auth_header

    token = auth_header.split(' ').last
    begin
      JWT.decode(
        token,
        nil,
        true,
        algorithms: 'RS256',
        iss: 'https://rudder.us.auth0.com/',
        verify_iss: true,
        aud: 'https://api.rudder.to',
        verify_aud: true
      ) do |header|
        jwks_hash[header['kid']]
      end
    rescue StandardError
      raise(AuthenticationError)
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get(URI('https://rudder.us.auth0.com/.well-known/jwks.json'))
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end

  def self.get_user(auth_header)
    raise(AuthenticationError) unless auth_header

    token = auth_header.split(' ').last
    decoded_token = JWT.decode(token, nil, false)
    decoded_token[0]['sub']
  end

  class AuthenticationError < StandardError
  end
end
