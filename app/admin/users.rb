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

  form do |f|
    f.inputs 'Basic User fields' do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.input :description, as: :froala_editor
      f.input :avatar, as: :file, hint: f.template.image_tag(f.object.avatar.url(:common_120))
    end

    f.actions
  end

  show do |c|
    attributes_table do
      row :email
      row :name
      row :description
      row :avatar do
        image_tag(c.avatar.url(:common_120))
      end
    end
  end

  permit_params :avatar, :email, :description, :name, :password, :password_confirmation
end
