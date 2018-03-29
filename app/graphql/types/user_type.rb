Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :avatar_url do
    type !types.String
    argument :style, !types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, _args, _ctx) {
      obj.avatar.url(:common_60)
    }
  end
  field :description, !types.String
  field :course_users, !types[Types::CourseUserType]
  field :id, !types.ID
  field :name, !types.String
end