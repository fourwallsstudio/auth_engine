module Auth
  module Generators
    class ScheduleGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates/", __FILE__)
      
      desc 'create schedule.rb file for running cron tasks'

      def copy_schedule
        template "schedule.rb", "config/schedule.rb"
      end
    end
  end
end
