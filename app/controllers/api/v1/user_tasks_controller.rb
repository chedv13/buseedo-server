module Api
  module V1
    class UserTasksController < Api::V1::BaseController
      before_action :set_user_task, only: :update

      def update
        modified_params = {}
        timestamp_fields = [:finished_at, :started_at]

        timestamp_fields.each do |timestamp_field|
          timestamp_field_value = user_task_params[timestamp_field]
          if timestamp_field_value
            modified_params[timestamp_field] = Time.at(timestamp_field_value.to_f)
          end
        end

        if @user_task.update(modified_params)
          render json: { result: 'OK' }
        else
          render json: @user_task.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user_task
        @user_task = UserTask.find(params[:id])
      end

      def user_task_params
        params.permit(:id, :finished_at, :started_at, :user_id)
      end
    end
  end
end