Connections::TaskConnectionWithTotalCountType = Types::TaskType.define_connection do
  name 'TaskConnectionWithTotalCount'
  description 'Обозначает, что у объекта есть задачи, как связь.'

  field :total_count do
    description 'Сколько всего задач содержится в объекте.'
    type types.Int
    description 'Total count of related tasks'
    resolve ->(obj, _, _) {
      obj.nodes.size
    }
  end
end