Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'Объект пользователя (или преподавателя).'

  field :avatar_url do
    description 'Ссылка на аватар пользователя.'
    type !types.String
    argument :style, types.String, "Possible styles: #{Course.cover_styles_hash}. Arguments are keys of hash."
    resolve ->(obj, args, ctx) {
      obj.full_attachment_url(ctx.to_h[:request].base_url, 'avatar', args['style'])
    }
  end
  field :course_users, !types[Types::CourseUserType]
  field :description do
    description 'Описание пользотваеля (О Себе).'
    type types.String
  end
  field :email do
    type !types.String
  end
  field :id, !types.Int
  field :first_name do
    description 'Имя пользователя.'
    type !types.String
  end
  field :last_name do
    description 'Фамилия пользователя.'
    type !types.String
  end
end
