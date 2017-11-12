module Api
  module V1
    class BaseController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      respond_to :json

      # TODO: Разобраться попозже с аутентификацией
      # before_action :authenticate_user!
    end
  end
end