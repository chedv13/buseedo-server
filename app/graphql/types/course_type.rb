Types::CourseType = GraphQL::ObjectType.define do
  name 'Course'
  field :description, !types.String
  field :final_number_of_points, !types.Int
  field :id, !types.ID
  field :name, !types.String
  field :cover_url do
    type !types.String
    argument :style, !types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, _args, _ctx) {
      obj.cover.url(:common_60)
    }
  end
end