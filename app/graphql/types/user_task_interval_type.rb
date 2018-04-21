Types::UserTaskIntervalType = GraphQL::ObjectType.define do
  name 'UserTaskInterval'
  field :finished_at do
    type types.Int
    resolve ->(obj, _, _) {
      obj.finished_at_seconds_since_1970
    }
  end
  field :id, !types.Int
  field :started_at do
    type !types.Int
    resolve ->(obj, _, _) {
      obj.started_at_seconds_since_1970
    }
  end
  field :task, Types::TaskType
end