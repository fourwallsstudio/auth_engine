module Auth
  module Generators
    class BlacklistTokenGenerator < Rails::Generators::Base

      namespace 'auth'
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a BlacklistToken model and job"

      def generate_model
        invoke "active_record:model", ['blacklist_token'], migration: false
      end

      #def inject_auth_content
      #  content = model_contents
      #  model_path = 'app/models/blacklist_token.rb'
      #  class_path = BlacklistToken

      #  inject_into_class model_path, class_path
      #end

    end
  end
end
