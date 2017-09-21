ActiveAdmin.register Task do
  filter :body, filters: [:contains]
  filter :number_of_percentages, filters: [:equals]
  filter :number_of_points, filters: [:equals]

  index do
    id_column
    column :body
    column :number_of_percentages
    column :number_of_points
    actions
  end
end
