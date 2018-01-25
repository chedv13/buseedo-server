require 'koala'

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::ApplicationController
      def create_from_facebook
        @graph = Koala::Facebook::API.new(params[:access_token])
        @graph.get_object('me?fields=id,name,email') do |data|
          email = data['email']

          # TODO: Здесь подумать еще раз. нужна ли генерация пароля?
          current_user = User.find_by(email: email)
          if current_user
            current_user.update_attributes!(name: data[:name])
          else
            current_user = User.create(
                email: email,
                name: data['name'],
                provider: :facebook,
                uid: email
            )
          end

          client_id = SecureRandom.urlsafe_base64(nil, false)
          token = SecureRandom.urlsafe_base64(nil, false)

          current_user.tokens[client_id] = {
              token: BCrypt::Password.create(token),
              expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
          }
          current_user.save

          sign_in(:user, current_user, store: false, bypass: false)

          render json: {
              result: {
                  data: current_user.token_validation_response
              }
          }
        end
      end

      def create_from_twitter

      end
    end
  end
end