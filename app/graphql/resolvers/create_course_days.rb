class Resolvers::CreateCourseDays < Resolvers::CourseMutation
  description 'Эта мутация добавляет дни к курсу.'

  argument :id do
    description 'Передается ID курса.'
    type !types.Int
  end
  argument :first_day_number do
    description 'Здесь принимается первый день интервала который мы хотим создать.'
    type !types.Int
  end
  argument :last_day_number do
    description 'Здесь принимается последний день интервала который мы хотим создать.'
    type !types.Int
  end

  type types[Types::DayType]

  def call(_obj, args, _ctx)
    current_days = Course.find(args[:id]).days

    ActiveRecord::Base.transaction do
      days = []
      (args[:first_day_number]..args[:last_day_number]).map do |day_number|
        if current_days.exists?(number: day_number)
          days = course.days.create!(number: day_number)
        end
      end
      days
    end
  end
end