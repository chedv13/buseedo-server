ActiveAdmin.register User do
  filter :email, filters: [:contains]
  filter :name, filters: [:contains]

  index do
    id_column
    column :email
    column :name
    column :gender
    actions
  end

  permit_params :avatar, :email, :name, :password, :password_confirmation

  form do |f|
    f.inputs 'Basic User fields' do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.input :avatar, as: :file # , hint: f.template.image_tag(f.object.avatar.url(:cover))
    end

    f.actions
  end
end
