require 'koala'

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::ApplicationController
      def create_from_facebook
        @graph = Koala::Facebook::API.new(params[:access_token])
        @graph.get_object('me?fields=id,name,email') do |data|
          email = data['email']

          # TODO: Здесь подумать еще раз. нужна ли генерация пароля?
          @resource = User.find_by(email: email)
          if @resource
            @resource.update_attributes!(name: data[:name])
          else
            @resource = User.create(
              email: email,
              name: data['name'],
              provider: :facebook,
              uid: email
            )
          end

          @client_id = SecureRandom.urlsafe_base64(nil, false)
          @token = SecureRandom.urlsafe_base64(nil, false)

          @resource.tokens[@client_id] = {
            token: BCrypt::Password.create(@token),
            expiry: (Time.zone.now + DeviseTokenAuth.token_lifespan).to_i
          }
          @resource.save

          sign_in(:user, @resource, store: false, bypass: false)

          render json: {
            data: @resource.token_validation_response
          }
        end
      end
    end
  end
end