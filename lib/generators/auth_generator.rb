module Auth
  module Generators
    class AuthGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      namespace 'auth'
      source_root File.expand_path('../templates', __FILE__)

      desc 'Generates a model with a given NAME'

      def create_migration_file
        migration_template 'migration.rb', "db/migrate/create_#{plural_name}_table.rb"
      end

      def generate_model
        invoke "active_record:model", [name], migration: false
      end

      def inject_auth_content
        content = model_contents
        model_path = "app/models/#{namespace}/#{name}.rb"
        class_path = name.camelize
        
        inject_into_class model_path, class_path, content 
        # inject_into_file model_path, "require 'bcrypt'\n\n", :before => "class User"
      end

      def migration_data
  <<-RUBY
## default columns
      t.string :username, null: false
      t.string :password_digest, null: false
  RUBY
      end

      def model_contents
   <<-RUBY
      validates :username, presence: true, uniqueness: true
      has_secure_password
   RUBY
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end
