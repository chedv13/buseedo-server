ActiveAdmin.register Subscriber do
  filter :email, filters: [:contains]

  index do
    id_column
    column :email
    column :created_at
    actions
  end

  permit_params :email

  form do |f|
    f.inputs 'Basic fields' do
      f.input :email
    end
    f.actions
  end
end
