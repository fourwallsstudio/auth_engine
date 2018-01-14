require 'auth/manager'

module Auth
  class Engine < ::Rails::Engine
    isolate_namespace Auth

    config.app_middleware.use Auth::Manager

    initializer "auth.load_app_instance_data" do |app|
      Auth.app_root = app.root
    end
    
    initializer "auth", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount Auth::Engine, at: '/auth'
      end    
    end

    initializer "auth.secret_key" do |app|
      if app.respond_to?(:secrets)
        Auth.secret_key ||= app.secrets.secret_key_base
      elsif app.config.respond_to?(:secret_key_base)
        Auth.secret_key ||= app.config.secret_key_base
      end
    end
  end
end
