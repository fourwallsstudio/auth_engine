require 'rails'
require 'auth/engine'

module Auth
  module Controllers
    autoload :Helpers, 'auth/controllers/helpers'
  end

  mattr_accessor :app_root
  @@app_root ||= nil

  mattr_accessor :blacklist_tokens
  @@blacklist_tokens ||= false

  mattr_accessor :redis_connection
  @@redis_connection ||= nil

  mattr_accessor :secret_key
  @@secret_key ||= nil

  mattr_accessor :resource_class
  @@resource_class ||= 'User' 

  mattr_accessor :default_scope
  @@default_scope = :user

  def self.setup
    yield self
  end
end
