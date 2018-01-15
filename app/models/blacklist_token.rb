class BlacklistToken 
  attr_accessor :token, :exp
  attr_reader :date_blacklisted

  def initialize(token = nil, exp = nil)
    @token = token
    @exp = exp
    @date_blacklisted = nil
  end

  def self.find_by_token(token)
    result = $REDIS.hget('blacklist_token', token)
    result.nil? ? {} : JSON.parse(result)
  end

  def self.all
    result = $REDIS.hgetall('blacklist_token')
    result.merge(result) { |_,v| JSON.parse v }
  end

  def self.expired_tokens
    all.select { |k,v| is_expired?(v['token']) }.to_a
  end
 
  def self.destroy(token)
    $REDIS.hdel 'blacklist_token', token
    true
  end

  def self.is_blacklisted?(token)
    !find_by_token(token).nil?
  end

  def self.is_expired?(token)
    expiration = find_by_token(token)['exp']
    expiration.to_i <= Time.now.to_i
  end

  def save
    return false unless valid? 

    @date_blacklisted = Time.now
    
    payload = { 
      token: token, 
      exp: exp,
      date_blacklisted: date_blacklisted 
    }
    
    begin
      $REDIS.mapped_hmset 'blacklist_token', { token => payload.to_json }
      true
    rescue
      @date_blacklisted = nil
    end
  end

  private

    def valid?
      !token.nil? && !exp.nil?
    end
end
