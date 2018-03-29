ActiveAdmin.register Course do
  filter :name, filters: [:contains]

  index do
    id_column
    column :name
    column :is_published
    column :published_at
    column :unpublished_at
    actions
  end

  form do |f|
    f.inputs 'Common' do
      f.input :name
      f.input :description
      f.input :full_description, as: :froala_editor
    end
    f.inputs 'Images' do
      f.input :cover, as: :file, hint: f.template.image_tag(f.object.cover.url(:common_60))
      f.input :background_image, as: :file, hint: f.template.image_tag(f.object.background_image.url(:ios_max))
    end
    f.actions
  end

  show do |c|
    attributes_table do
      row :name
      row :description
      row :full_description do
        c.full_description.html_safe if c.full_description
      end
      row :cover do
        image_tag(c.cover.url(:common_60))
      end
      row :background_image do
        image_tag(c.background_image.url(:ios_max))
      end
    end
  end

  permit_params :background_image, :cover, :description, :full_description, :name
end
