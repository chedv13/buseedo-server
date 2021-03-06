module Api
  module V1
    class DecisionsController < ApplicationController
      before_action :user_task

      def create
        @decision = Decision.new(decision_params)
        @decision.user_task = @user_task

        # TODO: Temporary - позже убрать
        @user_task.update_attributes!(is_completed: true)

        if @decision.save
          # TODO: Здесь сделать поиск следующей нерешенной задачи или просто создание новой
          current_day_task = @user_task.day_task
          next_day_task = @user_task.day_task.next_by_task_id

          if next_day_task.day_id == current_day_task.day_id
            user = @user_task.user
            # TODO: Вынести это все дело в callback
            next_user_task = UserTask.create(day_task: next_day_task, user: user)
            next_task = next_day_task.task

            render json: {
              data: {
                body: next_task.body,
                day_status: 'not_completed',
                id: next_user_task.id,
                name: next_task.name,
                number_of_points: next_task.number_of_points,
                number_of_percentages: next_day_task.number_of_percentages,
                skills: next_task.skills.map do |s|
                  {
                    id: s.id,
                    name: s.name
                  }
                end
              }
            }
          else
            render json: {
              data: {
                day_status: 'completed'
              }
            }
          end
        else
          render json: { errors: @decision.errors }, status: :unprocessable_entity
        end
      end

      private

      def decision_params
        params.require(:decision).permit(:body)
      end

      def user_task
        @user_task = UserTask.find(params[:user_task_id])
      end

    end
  end
end
