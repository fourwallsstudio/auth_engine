require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class AuthGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__) 

      def generate_model
        binding.pry
        invoke "active_record:model", [name], migration: false
      end
    end
  end
end
