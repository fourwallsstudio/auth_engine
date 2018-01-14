class Auth::SessionsController < AuthController

  def create
    resource = auth_manager.authenticate 

    if resource
      login resource
      render json: resource
    else
      render json: ['invalid username or password'], status: 401
    end
  end

  def destroy
    logout
  end
end
