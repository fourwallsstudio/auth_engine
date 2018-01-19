require 'jwt'

module JWTWrapper
  extend ActiveSupport::Concern

  def encode(payload, expiration=nil)
    # exp in seconds
    expiration ||= 24 * 3600

    payload = payload.dup
    payload['exp'] = Time.now.to_i + expiration
    puts "JWT payload: #{payload.inspect}"

    JWT.encode payload, Auth.secret_key
  end

  def decode(token)
    begin
    
      decoded = JWT.decode(token, Auth.secret_key)
      puts "decoded jwt: #{decoded}"
    
      # check if decoded token is blacklisted
      return nil if Auth.blacklist_tokens && BlacklistToken.is_blacklisted?(token)
      
      decoded.nil? ? nil : decoded.first
    
    rescue JWT::ExpiredSignature
      
      if Auth.blacklist_tokens
        bl_token = BlacklistToken.new decoded['token'], decoded['exp']
        bl_token.save
      end
    end
  end
end
