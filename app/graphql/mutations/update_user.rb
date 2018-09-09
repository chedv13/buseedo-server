Mutations::UpdateUser = GraphQL::Relay::Mutation.define do
  name 'UpdateUser'
  description 'Мутация обновляет данные пользователя.'

  input_field :academic_degree do
    description 'Обновляет данные об учёной степени пользователей.'
    type types.String
  end
  input_field :area_of_studies do
    description 'Обновляет данные об областях, которые изучал пользователь.'
    type types.String
  end
  input_field :country do
    description 'Обновляет данные о стране, в которой проживает, пользотваль.'
    type types.String
  end
  input_field :current_job do
    description 'Обновляет данные о текущем месте работы пользователя.'
    type types.String
  end
  input_field :dream_job do
    description 'Обновляет данные о месте работы, которое хочет пользователь.'
    type types.String
  end
  input_field :educational_institution do
    description 'Обновляет данные об образовательном учреждение, которое закончил пользователь.'
    type types.String
  end
  input_field :email do
    description 'Обновляет email пользователя.'
    type types.String
  end
  input_field :hobby do
    description 'Обновляет данные о хоббии пользователя.'
    type types.String
  end
  input_field :gender do
    description 'Обновляет данные данные о поле пользователя.'
    type types.Boolean
  end
  input_field :id do
    type !types.Int
  end
  input_field :is_first_filling_passed do
    description 'Заполнены ли первичные данные (первый экран после регистрации, поля: gender, name, country)'
    type types.Boolean
  end
  input_field :first_name do
    description 'Обновляет имя пользователя.'
    type types.String
  end
  input_field :last_name do
    description 'Обновляет фамилию пользователя.'
    type types.String
  end
  input_field :birth_date do
    description 'Обновляет день рождения пользователя.'
    type types.String
  end
  input_field :year_of_ending_of_educational_institution do
    description 'Обновляет данные о годе окончания пользователем образовательного учреждения.'
    type types.Int
  end

  return_field :user, Types::UserType

  resolve ->(_, inputs, _) {
    user = User.find(inputs[:id])
    modified_inputs_hash = inputs.to_h
    Rails.logger.info modified_inputs_hash
    modified_inputs_hash.delete(:id)
    user.update_attributes!(modified_inputs_hash)
    { user: user }
  }
end
