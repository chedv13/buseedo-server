Types::CourseType = GraphQL::ObjectType.define do
  name 'Course'

  connection :days, Connections::DayConnectionWithTotalCountType

  field :background_image_url do
    type !types.String
    argument :style, types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, ctx) {
      obj.full_attachment_url(ctx.to_h[:base_url], 'background_image', args['style'])
    }
  end
  field :cover_url do
    type !types.String
    argument :style, types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, ctx) {
      obj.full_attachment_url(ctx.to_h[:base_url], 'cover', args['style'])
    }
  end
  field :description, types.String
  field :final_number_of_points, !types.Int
  field :full_description, types.String
  field :id, !types.Int
  field :name, !types.String
  field :course_teachers, !types[Types::CourseTeacherType]
end