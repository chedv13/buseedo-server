ActiveAdmin.register Course do
  filter :name, filters: [:contains]

  index do
    id_column
    column :name
    column :is_published
    column :published_at
    column :unpublished_at
    column :final_number_of_points
    actions
  end

  form do |f|
    f.inputs 'Common' do
      f.input :name
      f.input :is_published
      f.input :description
      f.input :full_description, as: :froala_editor
    end
    f.inputs 'Images' do
      f.input :cover, as: :file, hint: f.template.image_tag(f.object.cover.url(:common_60))
      f.input :background_image, as: :file, hint: f.template.image_tag(f.object.background_image.url(:ios_max))
    end
    f.inputs 'Relationships' do
      f.input :teachers, as: :check_boxes, collection: User.all.map { |u| [u.name, u.id] }
    end
    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :is_published
      row :description
      row :full_description do
        c.full_description.html_safe if c.full_description
      end
      row :cover do
        image_tag(c.cover.url(:common_60))
      end
      row :background_image do
        image_tag(c.background_image.url(:ios_max), width: 200)
      end
      row :teachers do
        %{
        <ul style="padding-left: 5px; list-style: disc;">
          #{c.teachers.map { |s|
          "<li><a href='/admin/users/#{s.id}'>#{s.name}</a></li>"
        }.join('')}
        </ul>
      }.html_safe
      end
    end
  end

  permit_params :background_image, :cover, :description, :full_description, :is_published, :name, teacher_ids: []
end
