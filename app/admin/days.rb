ActiveAdmin.register Day do
  filter :number

  index do
    id_column
    column :user
    actions
  end
end
