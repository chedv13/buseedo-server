ActiveAdmin.register Decision do
  index do
    id_column
    column :body
    column :status
    actions
  end

  permit_params :body, :name, :number_of_percentages, :number_of_points, skill_ids: []

  form do |f|
    f.inputs 'Basic fields' do
      f.input :body
      f.input :status
    end
    f.actions
  end
end
