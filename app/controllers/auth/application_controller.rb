require_dependency "auth/application_controller"

module Auth
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
