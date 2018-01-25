module Api
  module V1
    class UserTasksController < Api::V1::BaseController
      before_action :set_user_task, only: :update

      # TODO: Это дело все отрефакторить и вынести обработку ошибок. Длинный метод.
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
          if modified_params[:finished_at]
            current_day_task = @user_task.day_task
            next_day_task = @user_task.day_task.next_by_task_id

            if next_day_task.day_id > current_day_task.day_id
              # Здесь создаем новый UserTask и сразу отправлеяем его
              user = User.find(params[:user_id])

              unless user
                render json: { errors: ['User not found '] }
              end

              next_user_task = UserTask.create(day_task: next_day_task, user: user)
              current_task = next_day_task.task

              # TODO: Вынести статусы дня в определенный enum (возможно сделать модель)
              render json: {
                  body: current_task.body,
                  day_status: 'not_completed',
                  id: next_user_task.id,
                  skills: current_task.skills.map do |s|
                    {
                        id: s.id,
                        name: s.name
                    }
                  end
              }
            else
              # TODO: Здесь сказать пользователю, что на сегодня все и мы пришлем следующую таску ему завтра
              render json: {
                  day_status: 'completed'
              }
            end
          end
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