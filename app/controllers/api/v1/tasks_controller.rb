module Api
  module V1
    class TasksController < Api::V1::BaseController
      include Api::Json::Generator

      before_action ->(klass = Task) { convert_fields klass }, only: %w(index show)
      before_action :build_relations_with_fields, only: %w(index show)
      before_action ->(klass = Task) { build_limit_params klass }, only: %w(index show)
      before_action ->(klass = Task) { build_condition klass }, only: %w(index show)

      def index
        query = Task.build_json_query(
            @fields,
            limit: @limit,
            offset: @offset,
            relations_with_fields: @relations_with_fields,
            condition: @condition
        )
        result = build_result(query)

        render json: result
      end

      def update
      end
    end
  end
end