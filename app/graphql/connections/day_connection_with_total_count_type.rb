Connections::DayConnectionWithTotalCountType = Types::DayType.define_connection do
  name 'DayConnectionWithTotalCount'
  description 'Обозначает, что у объекта есть дни, как связь.'

  field :total_count do
    description 'Сколько всего дней содержится в объекте.'
    type types.Int
    description 'Total count of related days'
    resolve ->(obj, _, _) {
      obj.nodes.size
    }
  end
end