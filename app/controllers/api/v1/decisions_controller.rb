module Api
  module V1
    class DecisionsController < ApplicationController
      before_action :user_task

      def create
        @decision = Decision.new(decision_params)
        @decision.user_task = @user_task

        if @decision.save
          # TODO: Здесь сделать поиск следующей нерешенной задачи или просто создание новой
          current_day_task = @user_task.day_task
          next_day_task = @user_task.day_task.next_by_task_id

          if next_day_task.day_id == current_day_task.day_id
            user = @user_task.user
            next_user_task = UserTask.create(day_task: next_day_task, user: user)
            current_task = next_day_task.task

            render json: {
              data: {
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
