class Resolvers::CourseMutation < GraphQL::Function
  type Types::CourseType

  def create_course_hash_and_find_user(args)
    cover_from_args = args[:cover]

    course_hash = {
      description: args[:description],
      full_description: args[:full_description],
      is_available_for_review: args[:is_available_for_review],
      name: args[:name],
    }

    if args.to_h.has_key? 'cover'
      decoded_cover_data = Base64.decode64(cover_from_args)
      cover_data = StringIO.new(decoded_cover_data)
      course_hash[:cover] = cover_data
    end

    [args[:user_id], course_hash]
  end
end