class Auth::RegistrationsController < AuthController

  def create
    @resource = resource_class.new(registration_params)

    if @resource.save
      login @resource
      render json: @resource
    else
      puts @resource.errors.full_messages
      render json: @resource.errors.full_messages, status: 422
    end
  end

  private

    def registration_params
      params.require(:user).permit(:username, :password)
    end
end
