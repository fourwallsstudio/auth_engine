class AuthController < ::ApplicationController
  skip_before_action :verify_authenticity_token

  include Auth::Controllers::Helpers

end
