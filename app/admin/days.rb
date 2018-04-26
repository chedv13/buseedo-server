ActiveAdmin.register Day do
  index do
    id_column
    column :number
    column 'Course' do |d|
      %{
        <a href='/admin/courses/#{d.course.id}'>#{d.course.name}</a>
      }.html_safe
    end
    actions
  end

  permit_params :course_id, :number

  form do |f|
    f.inputs 'Basic fields' do
      f.input :number, as: :number
    end
    f.inputs 'Relationships' do
      f.input :course, as: :select, collection: Course.all.map { |u| [u.name, u.id] }, include_blank: false
    end
    f.actions
  end
end
