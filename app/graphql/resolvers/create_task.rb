class Resolvers::CreateTask < Resolvers::CourseMutation
  description 'Эта мутация добавляет задачу к дню.'

  argument :body do
    description 'Передается описание задачи.'
    type !types.String
  end
  argument :day_id do
    description 'Передается ID дня.'
    type types.Int
  end
  argument :course_id do
    description 'Передается ID курса.'
    type types.Int
  end
  argument :is_published do
    description 'Передатеся значение "Опубликована ли задача?"'
    type types.Boolean
  end
  argument :name do
    description 'Передается наименование задачи.'
    type types.String
  end
  argument :number_of_percentages do
    description 'Передается количество процентов, которое дается за выполнение задачи в дне. Мы должны дойти до ста процентов, тогда день будет считаться сделанныым и больше в него нельзя будет добавлять задач.'
    type types.Float
  end
  argument :number_of_points do
    description 'Передается колчиество очков, которое мы даем пользователю за выполнение данной задачи. Нужно в скиллах польхзователя.'
    type types.Int
  end
  argument :serial_number do
    description 'Порядковый номер задачи в дне.'
    type types.Int
  end
  argument :skills do
    description 'Добавляет и создаёт скиллы к задаче.'
    type types[types.String]
  end

  type Types::TaskType

  def call(_obj, args, _ctx)
    if args[:course_id]
      course = Course.find(args[:course_id])
      number = course.days.empty? ? 1 : course.days.map{|day| day.number}.max + 1
      day = course.days.create!(number: number)
    else
      day = Day.find(args[:day_id])
    end

    ActiveRecord::Base.transaction do
      task_hash = args.to_h
      task_hash[:serial_number] = 1 if !task_hash[:serial_number]
      task_hash[:number_of_points] = 1 if !task_hash[:number_of_points]
      task_hash[:number_of_percentages] = 10 if !task_hash[:number_of_percentages]
      puts task_hash.inspect
      %w(day_id course_id skills).each { |key| task_hash.delete(key) }
      task = day.tasks.create!(task_hash)
      skills =  args[:skills] || []
      skills.each do |skill_name|
        task.skills << if Skill.exists?(name: skill_name)
                         Skill.find_by_name(skill_name)
                       else
                         Skill.create!(name: skill_name)
                       end
      end
      task
    end
  end
end
