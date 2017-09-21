module JsonQuery
  module Associations
    module Validator
      def select_valid_relations_and_fields(relations, relation_names_with_fields)
        relation_names_with_fields.each_with_object({}) do |(relation_name, fields), result_hash|
          relation = relations.find {|r| r.name == relation_name.to_sym}

          next unless relation

          transmitted_association_fields = fields.map {|x| x.split('.')[1]}.compact

          result_hash[relation] =
              if relation.options.key?(:polymorphic) &&
                  relation.is_a?(ActiveRecord::Reflection::BelongsToReflection)
                validate_polymorphic_association_fields(relation, transmitted_association_fields)
              elsif relation.is_a?(ActiveRecord::Reflection::ThroughReflection)
                validate_association_with_through_fields(relation, transmitted_association_fields)
              else
                validate_association_fields(relation, transmitted_association_fields)
              end
        end
      end

      def validate_association_fields(relation, transmitted_fields)
        relation_fields = relation.klass.columns_hash.keys
        table_name = relation.table_name

        fields =
            if transmitted_fields.empty?
              relation_fields
            else
              transmitted_fields.select {|f| relation_fields.include?(f)}
            end

        fields = fields.map {|f| "#{table_name}.#{f}"}

        if relation.klass.respond_to?(:attachment_definitions)
          attachment_definitions_keys = relation.klass.attachment_definitions.keys.map(&:to_s)

          transmitted_fields.each do |field|
            style = 'original'

            if field.include?('[')
              style_array = field.scan(/\[([^\)]+)\]/)

              unless style_array.empty?
                field = field.split('[')[0]
                style = style_array[0][0]
              end
            end

            if attachment_definitions_keys.include?(field)
              fields.push("get_#{table_name}_#{field}_url(\"#{table_name}\".\"id\", '#{style}', \"#{table_name}\".\"#{field}_file_name\") AS #{field}")
            end
          end
        end

        fields
      end

      # TODO: Сделать обработку Paperclip
      def validate_polymorphic_association_fields(relation, fields)
        selected_relations = ActiveRecord::Base.descendants.map do |d|
          d.reflect_on_all_associations.select do |r|
            r.options.key?(:as) && r.options[:as] == relation.name
          end
        end.flatten

        if fields.empty?
          selected_relations.each_with_object({}) do |r, h|
            table_name = r.active_record.table_name
            h[table_name] = r.active_record.columns_hash.keys.map do |f|
              "#{table_name}.#{f}"
            end
          end
        else
          selected_relations.each_with_object({}) do |r, h|
            table_name = r.active_record.table_name
            selected_fields = fields.select do |field|
              r.active_record.columns_hash.keys.include?(field)
            end

            h[table_name] = selected_fields.map {|f| "#{table_name}.#{f}"}
          end
        end
      end

      # TODO: Сделать обработку Paperclip
      def validate_association_with_through_fields(relation, transmitted_fields)
        delegate_reflection = relation.delegate_reflection
        relation_fields = Object.const_get(delegate_reflection.class_name).columns_hash.keys
        table_name = delegate_reflection.table_name
        fields =
            if transmitted_fields.empty?
              relation_fields
            else
              transmitted_fields.select {|x| relation_fields.include?(x)}
            end

        fields.map {|f| "#{table_name}.#{f}"}
      end
    end
  end
end