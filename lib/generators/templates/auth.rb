Auth.setup do |config|
  require 'auth/orm/active_record'
  
  # enable blacklist tokens
  # requires 'redis-rails' and 'redis-namespace' for storing blacklistend tokens
  #
  # config.blacklist_tokens = true
end