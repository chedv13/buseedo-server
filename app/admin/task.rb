ActiveAdmin.register Task do
  filter :body, filters: [:contains]
  filter :number_of_percentages, filters: [:equals, :greater_than, :less_than]
  filter :number_of_points, filters: [:equals]

  index do
    id_column
    column :name
    column :body
    column :is_default
    column :number_of_points
    column 'Skills' do |task|
      %{
        <ul style="padding-left: 5px; list-style: disc;">
      #{task.skills.map { |s|
        "<li><a href='/admin/skills/#{s.id}'>#{s.name}</a></li>"
      }.join('')}
        </ul>
      }.html_safe
    end
    actions
  end

  permit_params :body, :name, :number_of_percentages, :number_of_points, skill_ids: []

  form do |f|
    f.inputs 'Basic fields' do
      f.input :name
      f.input :body
      f.input :is_default
      f.input :number_of_points
    end
    f.inputs 'Relationships' do
      f.input :skills, as: :select, input_html: { multiple: true, size: 10 }
    end
    f.actions
  end
end
