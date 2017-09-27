module Api
  module V1
    class SkillsController < Api::V1::BaseControllers
      before_action :authenticate_user!
    end
  end
end
