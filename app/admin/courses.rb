ActiveAdmin.register Course do
  index do
    id_column
    column :name
    column :is_published
    column :published_at
    column :unpublished_at
    actions
  end
end
