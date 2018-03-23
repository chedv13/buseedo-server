module Api
  module V1
    class CountriesController < Api::V1::BaseController
      def index
        sleep rand(2..10)
        render json: {
          # TODO: Вынести это формирование в глобальную константу
          data: Country.all.map(&:name).sort
        }
      end
    end
  end
end
