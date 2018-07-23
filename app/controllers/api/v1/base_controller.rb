module Api
  module V1
    class BaseController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      # protect_from_forgery with: :null_session
      # skip_before_action :verify_authenticity_token
      protect_from_forgery unless: -> { request.format.json? }
      skip_before_action :verify_authenticity_token

      respond_to :json
    end
  end
end