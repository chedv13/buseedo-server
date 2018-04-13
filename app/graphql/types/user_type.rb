Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  field :avatar_url do
    type !types.String
    argument :style, !types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, _) {
      args.key?('style') ? obj.avatar.url(args['style']) : obj.avatar.url
    }
  end
  field :course_users, !types[Types::CourseUserType]
  field :description, types.String
  field :email, !types.String
  field :id, !types.Int
  field :name, !types.String
end