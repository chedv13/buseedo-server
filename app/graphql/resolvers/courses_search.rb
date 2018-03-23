require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

class Resolvers::CoursesSearch
  include SearchObject.module(:graphql)

  scope { Course.published }
  type !types[Types::CourseType]

  def fetch_results
    return super unless context.present?

    GraphQL::QueryResolver.run(Course, context, Types::CourseType) do
      super
    end
  end
end
