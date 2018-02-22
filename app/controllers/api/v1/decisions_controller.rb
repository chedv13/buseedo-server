module Api
  module V1
    class DecisionsController < ApplicationController
      before_action :user_task

      def create
        @decision = Decision.new(decision_params)
        @decision.user_task = @user_task

        if @decision.save
          render json: { data: @decision }
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
