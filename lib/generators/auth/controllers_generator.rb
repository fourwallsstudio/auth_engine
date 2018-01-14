module Auth
  module Generators

    class ControllersGenerator < Rails::Generators::Base
      CONTROLLERS = %w(sessions).freeze

      desc 'create auth controllers'

      source_root File.expand_path("../../templates/controllers", __FILE__)


      argument :scope, required: true

      def create_controllers
        @scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
        controllers = CONTROLLERS   #TODO: add options[:controller]
        controllers.each do |name|
          template "#{name}_controller.rb",
            "app/controllers/#{scope}/#{name}_controller.rb"
        binding.pry
        end 
      end
    end
  end
end
