ActiveAdmin.register UserTask do
  filter :is_completed

  index do
    id_column
    column :task
    column :user
    column :is_completed
    column :is_current
    actions
  end
end
