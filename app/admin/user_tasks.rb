ActiveAdmin.register UserTask do
  filter :is_completed

  index do
    id_column
    column :is_completed
    column :user
    column :day_task
    actions
  end
end
