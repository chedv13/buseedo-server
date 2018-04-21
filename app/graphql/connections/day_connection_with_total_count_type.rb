Connections::DayConnectionWithTotalCountType = Types::DayType.define_connection do
  name 'DayConnectionWithTotalCount'

  field :total_count do
    type types.Int
    description 'Total count of related days'
    resolve ->(obj, _, _) {
      obj.nodes.size
    }
  end
end