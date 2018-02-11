module Api
  module V1
    class UserTimeIntervalsController < ApplicationController
      before_action :set_user_task, only: :update

      def create
        @user_task_interval = UserTaskInterval.new(user_task_interval_params)

        if @user_task_interval.save
          render json: { result: 'OK' }
        else
          render json: @user_task_interval.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user_task_interval.update(user_task_interval_params)

        else
          render json: { errors: @user_task_interval.errors, status: :unprocessable_entity }
        end

        # if @user_task.update(user_task_params)
        #   if user_task_params[:finished_at]
        #     current_day_task = @user_task.day_task
        #     next_day_task = @user_task.day_task.next_by_task_id
        #
        #     if next_day_task.day_id > current_day_task.day_id
        #       # Здесь создаем новый UserTask и сразу отправлеяем его
        #       user = User.find(params[:user_id])
        #
        #       render json: { errors: ['User not found'] } unless user
        #
        #       next_user_task = UserTask.create(day_task: next_day_task, user: user)
        #       current_task = next_day_task.task
        #
        #       # TODO: Вынести статусы дня в определенный enum (возможно сделать модель)
        #       render json: {
        #           body: current_task.body,
        #           day_status: 'not_completed',
        #           id: next_user_task.id,
        #           skills: current_task.skills.map do |s|
        #             {
        #                 id: s.id,
        #                 name: s.name
        #             }
        #           end
        #       }
        #     else
        #       # TODO: Здесь сказать пользователю, что на сегодня все и мы пришлем следующую таску ему завтра
        #       render json: {
        #           day_status: 'completed'
        #       }
        #     end
        #   else
        #
        #   end
        # else
        #   render json: @user_task.errors, status: :unprocessable_entity
        # end
      end

      private

      def user_task_interval_params
        params.permit(:id, :is_finishing, :value)
      end

      def set_user_task
        @user_task = UserTask.find(params[:user_task_id])
      end
    end
  end
end