class Resolvers::DeleteTask < Resolvers::CourseMutation
  description 'Эта мутация удаляет задачу.'

  argument :id do
    description 'Передается ID задачи.'
    type !types.Int
  end

  type Types::TaskType

  def call(_obj, args, _ctx)
    task = Task.find(args[:id])
    task.destroy!
    task
  end
end
