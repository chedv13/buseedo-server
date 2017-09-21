module Api
  module V1
    class UsersController < ApplicationController
      include Api::Json::Generator

      respond_to :json

      before_action ->(klass=User) { convert_fields klass }, only: %w(index show)
      before_action :build_relations_with_fields, only: %w(index show)
      before_action ->(klass=User) { build_limit_params klass }, only: %w(index show)
      before_action ->(klass=User) { build_condition klass }, only: %w(index show)

      def index
        query = User.build_json_query(
            @fields,
            limit: @limit,
            offset: @offset,
            relations_with_fields: @relations_with_fields,
            condition: @condition
        )
        result = build_result(query)

        render json: result
      end

      def show
        query = User.build_json_query(
            @fields,
            limit: 1,
            offset: @offset,
            relations_with_fields: @relations_with_fields,
            condition: @condition
        )
        result = build_result(query)

        render json: result['data'].length ? result['data'][0] : {}
      end
    end
  end
end