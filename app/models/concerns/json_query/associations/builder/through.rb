module JsonQuery
  module Associations
    module Builder
      module Through
        def build_has_many_through_query(relation, fields)
          table_name = self.table_name
          delegate_reflection = relation.delegate_reflection
          relation_table_name = delegate_reflection.table_name
          join_table_foreign_key =
              if delegate_reflection.options.key?(:foreign_key)
                delegate_reflection.options[:foreign_key]
              else
                "#{delegate_reflection.class_name.underscore}_id"
              end
          joins = %(
            INNER JOIN #{relation_table_name}
                ON "#{relation.options[:through]}"."#{join_table_foreign_key}" =
                  #{relation_table_name}."#{Object.const_get(delegate_reflection.class_name).primary_key}"
          )

          condition = %(
          #{joins}
            WHERE "#{relation.options[:through]}"."#{delegate_reflection.foreign_key}" =
              "#{table_name}"."#{self.primary_key}"
          )

          build_result(
              delegate_reflection, fields, condition, relation_table_name,
              join_table_name: relation.options[:through]
          )
        end

        def build_has_one_through_query(relation, fields)
          table_name = self.table_name
          primary_key = self.primary_key
          delegate_reflection = relation.delegate_reflection
          relation_join_table_name = delegate_reflection.join_table
          relation_table_name = delegate_reflection.table_name
          join_table_foreign_key =
              if delegate_reflection.options.key?(:foreign_key)
                delegate_reflection.options[:foreign_key]
              else
                "#{delegate_reflection.class_name.underscore}_id"
              end
          joins = %(
            INNER JOIN #{relation_table_name}
              ON "#{relation_table_name}"."#{join_table_foreign_key}" =
                "#{relation_join_table_name}"."#{delegate_reflection.model.primary_key}"
          )

          %(
            (
              SELECT row_to_json(t)
              FROM (
                SELECT
                  "#{table_name}"."#{primary_key}"
                  #{fields.empty? ? '' : ", #{fields.join(',')}"}
                FROM #{relation_join_table_name} #{joins}
                WHERE "#{relation_join_table_name}"."#{join_table_foreign_key}" =
                  "#{table_name}"."#{primary_key}"
              ) t
            ) AS #{table_name}
          )
        end

        def build_through_query(relation, fields)
          case relation.delegate_reflection.class.name
          when 'ActiveRecord::Reflection::HasManyReflection'
            self.build_has_many_through_query(relation, fields)
          when 'ActiveRecord::Reflection::HasOneReflection'
            self.build_has_one_through_query(relation, fields)
          else
            Rails.logger.info('Error in through query building')
          end
        end
      end
    end
  end
end
