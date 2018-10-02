Connections::CourseConnection = Types::CourseType.define_connection do
  name 'CourseConnection'
  description 'Возвращает объекты курсов вместе с total_count.'

  field :total_count do
    description 'Общее количество объектов.'
    type types.Int

    resolve ->(_, _, ctx) {
      parent_args_hash = ctx.irep_node.parent.ast_node.arguments.inject({}) do |r, s|
        r.merge!({ s.name => s.value })
      end

      courses = Course.published
      courses = courses.where("name ILIKE '%#{parent_args_hash['q']}%'").order('name DESC') if parent_args_hash.key? 'q'
      courses = courses.order(parent_args_hash['order']) if parent_args_hash.key? 'order'
      courses.count
    }
  end
end
