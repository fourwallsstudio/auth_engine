require 'auth/concerns/jwt_wrapper'

module Auth
  class Proxy
    include JWTWrapper

    attr_reader :env, :manager, :config, :auth_header

    def initialize(env, manager)
      @env, @manager = env, manager
      @config = manager.config.dup
    end

    def request
      @request ||= ActionDispatch::Request.new(@env)
    end

    def set_auth_header(payload)
      @auth_header = payload 
    end

    def params
      request.params
    end

    def scope
      Auth.default_scope
    end

    def resource_class
      Auth.resource_class.constantize
    end

    def user
    end

    def logged_in?
      !!user
    end

    def authenticate
      return authenticate_by_token if authenticate_by_token
      puts 'auth by pw'
      authenticate_by_password
    end

    def login(resource)
      set_jwt_token resource
    end

    def logout
      blacklist_token
    end

    protected

      def authenticate_by_token
        return false unless request.headers.key? 'Authorization'
        return false unless claims
        return false unless claims.has_key?('user_id')

        puts 'auth by token'
        resource_class.find claims['user_id']
      end

      def authenticate_by_password
        return false unless params[scope]

        username, pw = params[scope]['username'], params[scope]['password']
        resource_class.find_by_username(username).try(:authenticate, pw)
      end

      def set_jwt_token(resource)
        id = resource.respond_to?(:id) ? resource.id : resource['id']
        payload = { user_id: id }
        token = encode payload
        set_auth_header "bearer #{token}"
      end
    
      def claims
        strategy, token = request.headers['Authorization'].split(' ')

        return nil if (strategy || '').downcase != 'bearer'

        decode(token)
      end

      def blacklist_token
        return false unless request.headers.key? 'Authorization'
        token = request.headers['Authorization'].split(' ').last
        decoded = decode token
        bl_token = BlacklistToken.new(decoded['token'], decoded['exp'])
        bl_token.save
      end
  end
end
