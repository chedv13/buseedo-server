module Api
  module V1
    class UsersController < Api::V1::BaseController
      include Api::Json::Generator
      before_action ->(klass = User) { convert_fields klass }, only: %i[index show]
      before_action :build_relations_with_fields, only: %i[index show]
      before_action :set_user, only: :update
      before_action ->(klass = User) { build_limit_params klass }, only: %i[index show]
      before_action ->(klass = User) { build_condition klass }, only: %i[index show]

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

      def update
        if @user.update(user_params)
          # TODO: Подумать, что можно точно отдавать
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(
          :country, :is_first_filling_passed, :name, :gender, :area_of_studies,
          :educational_institution, :year_of_ending_of_educational_institution,
          :hobby, :current_job, :dream_job
        )
      end
    end
  end
end