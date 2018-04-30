ActiveAdmin.register Task do
  active_admin_import

  filter :body, filters: [:contains]
  filter :number_of_percentages, filters: [:equals, :greater_than, :less_than]
  filter :number_of_points, filters: [:equals]

  index do
    id_column
    column :name
    column :body
    column :is_published
    column :serial_number
    column :number_of_points
    column :number_of_percentages
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

  permit_params :body, :day, :is_published, :name, :number_of_percentages, :number_of_points, :serial_number, skill_ids: []

  form do |f|
    f.inputs 'Basic fields' do
      f.input :name
      f.input :body, as: :froala_editor
      f.input :is_published
      f.input :serial_number
      f.input :number_of_points
      f.input :number_of_percentages
    end
    f.inputs 'Relationships' do
      f.input :day, as: :select, collection: Day.all.map { |d| ["course: #{d.course.name} - day_number: #{d.number}", d.id] }, include_blank: false
      f.input :skills, as: :select, input_html: { multiple: true, size: 10 }
    end
    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :body do
        c.body.html_safe
      end
      row :is_published
      row :serial_number
      row :number_of_points
      row :number_of_percentages
      row :day do
        "course: #{c.day.course.name} - day_number: #{c.day.number}"
      end
      row :skills do
        c.skills.map { |s| s.name }.to_s
      end
    end
  end
end
