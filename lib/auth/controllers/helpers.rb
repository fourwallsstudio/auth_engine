module Auth
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      def authenticate
        auth_manager.authenticate
      end

      def login(resource)
        auth_manager.login resource
      end

      def logout
        auth_manager.logout
      end

      def auth_manager
        request.env['auth.manager']
      end

      def resource_class
        Auth.resource_class.constantize
      end
    end
  end
end
