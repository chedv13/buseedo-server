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

  type Types::CourseType

  def call(_obj, args, _ctx)
    course = Course.find(args[:id])

    ActiveRecord::Base.transaction do
      (args[:first_day_number]..args[:last_day_number]).each do |day_number|
        course.days.create!(number: day_number)
      end

      course
    end
  end
end