require 'auth/proxy'

module Auth
  class Manager

    attr_accessor :config

    def initialize(app, options={})
      @app, @config = app, options
    end

    def call(env)
      # make thread safe
      dup._call env
    end

    def _call(env)
      return @app.call(env) if env['auth.manager'] && 
        env['auth.manager'].manager != self

      env['auth.manager'] = Proxy.new(env, self)

      status, headers, body = @app.call(env)
      
      if env['auth.manager'].respond_to? :auth_header
        headers['Authorization'] = env['auth.manager'].auth_header
      end
      
      body.tap { |msg| p "Auth::Manager : #{msg}" }

      p "status: #{status}"
      p "headers: #{headers}"
      [status, headers, body]
    end
  end
end
