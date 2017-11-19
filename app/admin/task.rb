ActiveAdmin.register Task do
  filter :body, filters: [:contains]
  filter :number_of_percentages, filters: [:equals, :greater_than, :less_than]
  filter :number_of_points, filters: [:equals]

  index do
    id_column
    column :body
    column :number_of_percentages
    column :number_of_points
    actions
  end

  permit_params :body, :number_of_percentages, :number_of_points

  form do |f|
    f.inputs 'Basic fields' do
      f.input :body
      f.input :number_of_percentages
      f.input :number_of_points
    end
    f.inputs 'Relationships' do
      f.input :skills, as: :select, input_html: { multiple: true, size: 10 }
    end
    f.actions
  end
end
