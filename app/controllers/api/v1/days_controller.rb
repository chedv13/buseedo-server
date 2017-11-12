module Api
  module V1
    class DaysController < Api::V1::BaseController
      include Api::Json::Generator

      before_action ->(klass=Day) { convert_fields klass }, only: %w(index show)
      before_action :build_relations_with_fields, only: %w(index show)
      before_action ->(klass=Day) { build_limit_params klass }, only: %w(index show)
      before_action ->(klass=Day) { build_condition klass }, only: %w(index show)

      def index
        query = Day.build_json_query(
            @fields,
            limit: @limit,
            offset: @offset,
            relations_with_fields: @relations_with_fields,
            condition: @condition
        )
        result = build_result(query)

        render json: result
      end
    end
  end
end
