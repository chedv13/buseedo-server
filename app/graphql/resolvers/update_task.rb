class Resolvers::UpdateTask < Resolvers::CourseMutation
  description 'Эта мутация добавляет задачу к дню.'

  argument :body do
    description 'Передается описание задачи.'
    type types.String
  end
  argument :id do
    description 'Передается ID задачи.'
    type !types.Int
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
    task = Task.find(args[:id])

    ActiveRecord::Base.transaction do
      task_hash = args.to_h
      %w(day_id skills).each { |key| task_hash.delete(key) }
      task.update_attributes!(task_hash)
      task.skills = []
      args[:skills].each do |skill_name|
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