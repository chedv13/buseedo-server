require 'active_support/concern'

module AttachmentUrlFunctionBuilder
  extend ActiveSupport::Concern

  class_methods do
    def build_attachment_url_function(field)
      table_name = self.table_name
      attachment_definitions = self.attachment_definitions
      attachment_definition_name = field.split('__')[0]
      attachment_definition = attachment_definitions[attachment_definition_name.to_sym]
      style = if attachment_definition.has_key?(:styles)
                reported_style = field.split('__')[1]
                reported_style && attachment_definition[:styles].has_key?(reported_style.to_sym) ? reported_style : 'original'
              else
                'original'
              end

      %{
      CASE WHEN cover_file_name IS NULL
        THEN NULL
        ELSE
          get_#{table_name}_#{attachment_definition_name}_url("#{table_name}"."id", '#{style}', "#{table_name}"."#{attachment_definition_name}_file_name")
       END AS #{attachment_definition_name}
      }
    end
  end
end
