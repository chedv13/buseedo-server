Types::DayType = GraphQL::ObjectType.define do
  name 'Day'
  field :id, !types.Int
  field :is_completed do
    type !types.Boolean
    resolve ->(obj, args, _) {

      # args.key?('style') ? obj.avatar.url(args['style']) : obj.avatar.url
    }
  end
  field :number, !types.Int
end