Connections::TaskConnectionWithTotalCountType = Types::TaskType.define_connection do
  name 'TaskConnectionWithTotalCount'

  field :total_count do
    type types.Int
    description 'Total count of related tasks'
    resolve ->(obj, _, _) {
      obj.nodes.size
    }
  end
end