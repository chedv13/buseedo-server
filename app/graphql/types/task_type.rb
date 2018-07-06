Types::TaskType = GraphQL::ObjectType.define do
  name 'Task'
  description 'Объект, обозначающий задание.'

  field :body do
    description 'Тело задания. Может быть в HTML.'
    type !types.String
  end
  field :day do
    description 'Связь с объектом дня.'
    type Types::DayType
  end
  field :day_id do
    description 'ID дня.'
    type !types.Int
  end
  field :id, !types.Int
  field :name do
    description 'Наименование задания.'
    type !types.String
  end
  field :number_of_percentages do
    description 'Проценты, начисляемые за выполнение задания. Когда выполняешь все задания в объекте UserDay становится 100% и можно сказать, что пользователь прошел все таски за день.'
    type !types.Int
  end
  field :number_of_points do
    description 'Количтесво очков, начиляемое пользователю за выполнение задания.'
    type !types.Int
  end
  field :serial_number do
    description 'Порядковый номер задания по прохождению на день.'
    type !types.Int
  end
  field :skills do
    description 'Навыки прибретаемые в процессе выполнения задания.'
    type !types[Types::SkillType]
  end
end