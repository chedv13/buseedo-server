Types::CourseType = GraphQL::ObjectType.define do
  name 'Course'
  field :description, !types.String
  field :id, !types.ID
  field :name, !types.String
  field :cover_url do
    type !types.String
    argument :style, !types.String, "Favorite thing to eat"
    resolve ->(obj, _args, _ctx) {
      jkasdasd
      obj.cover.url(:common_60)
    }
  end
end