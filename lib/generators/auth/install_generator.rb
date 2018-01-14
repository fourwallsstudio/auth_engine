module Auth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates an Auth initializer"
      class_option :orm

      def copy_initializer
        template "auth.rb", "config/initializers/auth.rb"
      end
    end
  end
end
