DeviseTokenAuth::RegistrationsController.class_eval do
  def render_create_success
    render json: {
        status: 'success',
        data: @resource.token_validation_response
    }
  end
end