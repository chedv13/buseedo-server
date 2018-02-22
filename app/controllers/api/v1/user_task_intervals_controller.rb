module Api
  module V1
    class UserTaskIntervalsController < ApplicationController
      before_action :user_task

      def create
        @user_task_interval = UserTaskInterval.new(user_task_interval_params)
        @user_task_interval.user_task = @user_task

        if @user_task_interval.save
          render json: { data: @user_task_interval }
        else
          render json: { erros: @user_task_interval.errors }, status: :unprocessable_entity
        end
      end

      def update
        @user_task_interval = UserTaskInterval.find(params[:id])

        if @user_task_interval.update(user_task_interval_params)
          render json: @user_task_interval
        else
          render json: { errors: @user_task_interval.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_task_interval_params
        UserTaskInterval::SYSTEM_DATETIME_FIELDS.each do |timestamp_field|
          timestamp_field_value = params[:interval][timestamp_field]
          params[:interval][timestamp_field] = Time.zone.at(timestamp_field_value.to_f) if timestamp_field_value
        end
        params.require(:interval).permit(:id, :finished_at, :started_at)
      end

      def user_task
        @user_task = UserTask.find(params[:user_task_id])
      end
    end
  end
end