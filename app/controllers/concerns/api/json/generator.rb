require 'active_support/concern'

# == Api::Json::Generator concern
#
# Contains functionality for api params parsing
#
module Api
  module Json
    module Generator
      extend ActiveSupport::Concern

      def build_condition(klass)
        condition_params = params.select do |k, v|
          !%w(fields relationships format controller action).include?(k) && klass.columns_hash.keys.include?(k)
        end

        if condition_params.empty?
          @condition = ''
          return
        end

        result = []
        condition_params.each do |param, val|
          if val.instance_of? String
            result.push("#{param} = '#{val}'")
          else
            val.each do |condition_op, op_val|
              if %w(like ilike).include?(condition_op)
                result.push("#{param} #{condition_op} '%#{op_val}%'")
              end
            end
          end
        end

        @condition = "WHERE #{result.join(' AND ')}"
      end

      def build_limit_params(klass)
        @limit = params[:per_page] ? params[:per_page].to_i : klass.default_per_page
        @page = params[:page] ? params[:page].to_i : 1
        @offset = @page == 1 ? 0 : (@page - 1) * @limit
      end

      def build_relations_with_fields
        @relations_with_fields =
            if params[:relationships]
              params[:relationships].split(',').group_by { |f| f.split('.')[0] }
            else
              {}
            end
      end

      def build_result(query)
        result = ActiveRecord::Base.connection.instance_variable_get('@connection').exec(query)[0]

        %w(data meta).each do |field|
          result[field] = JSON.parse(result[field].gsub(/([a-z]+)/, '\1'))
        end

        result
      end

      # TODO: Refactor method
      def convert_fields(klass)
        klass_columns = klass.columns_hash.keys

        @fields =
            if params[:fields]
              fields = params[:fields].split(',')
              permitted_transmitted_fields = fields.select { |x| klass_columns.include?(x) }
              remaining_fields = fields - permitted_transmitted_fields

              # if klass.respond_to?(:attachment_definitions)
              #   attachment_definitions = klass.attachment_definitions
              #   unless attachment_definitions.empty?
              #     # table_name = klass.table_name
              #     attachment_fields = fields
              #                             .select { |field| attachment_definitions.has_key?(field.split('__')[0].to_sym) }
              #                             .map do |field|
              #       klass.build_attachment_url_function(field)
              #
              #       # attachment_definition_name = field.split('__')[0]
              #       # attachment_definition = attachment_definitions[attachment_definition_name.to_sym]
              #       # style = if attachment_definition.has_key?(:styles)
              #       #           reported_style = field.split('__')[1]
              #       #           reported_style && attachment_definition[:styles].has_key?(reported_style.to_sym) ? reported_style : 'original'
              #       #         else
              #       #           'original'
              #       #         end
              #       # %{
              #       #   CASE WHEN cover_file_name IS NULL
              #       #     THEN NULL
              #       #     ELSE
              #       #       get_#{table_name}_#{attachment_definition_name}_url("#{table_name}"."id", '#{style}', "#{table_name}"."#{attachment_definition_name}_file_name")
              #       #     END AS #{attachment_definition_name}
              #       # }
              #     end
              #     permitted_transmitted_fields += attachment_fields
              #   end
              # end

              remaining_fields.each do |field|
                split_field = field.split('[')
                method_name = split_field[0]

                if split_field.length > 1
                  method_params = split_field[1].split(']')[0]

                  if klass.respond_to?(method_name)
                    permitted_transmitted_fields.push(klass.send(method_name, method_params))
                  end
                else
                  if klass.respond_to?(method_name)
                    permitted_transmitted_fields.push(klass.send(method_name))
                  end
                end
              end

              permitted_transmitted_fields.empty? ? klass_columns : permitted_transmitted_fields
            else
              klass_columns
            end
      end
    end
  end
end
