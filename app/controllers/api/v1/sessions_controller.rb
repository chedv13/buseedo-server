module Api
  module V1
    class SessionsController < Devise::SessionsController
      protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.include? 'application/json' }

      respond_to :json

      def create
        self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end

      def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
        yield if block_given?
        render json: { notice: 'Log Out' }
      end
    end
  end
end