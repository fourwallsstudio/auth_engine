require 'jwt'

module JWTWrapper
  extend ActiveSupport::Concern

  def encode(payload, expiration=nil)
    # exp in seconds
    expiration ||= 24 * 3600

    payload = payload.dup
    payload['exp'] = Time.now.to_i + expiration

    JWT.encode payload, Auth.secret_key
  end

  def decode(token)
    begin
    decoded = JWT.decode(token, Auth.secret_key)
    puts "decoded jwt: #{decoded}"
    # check if decoded token is blacklisted
    return nil if Auth.blacklist_tokens && BlacklistToken.is_blacklisted?(decoded)
    decoded.nil? ? nil : decoded.first
    rescue JWT::ExpiredSignature
      # handle expired token
    end
  end
end
