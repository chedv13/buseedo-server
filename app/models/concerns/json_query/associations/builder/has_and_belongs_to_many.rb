module JsonQuery
  module Associations
    module Builder
      module HasAndBelongsToMany
        def build_has_and_belongs_to_many_query(table_name, relation, fields)
          relation_table_name = relation.table_name
          relation_join_table_name = relation.join_table
          join_table_foreign_key =
              if relation.options.key?(:foreign_key)
                relation.options[:foreign_key]
              else
                "#{relation.class_name.underscore}_id"
              end
          condition = %(
              INNER JOIN #{relation_table_name}
                ON "#{relation_join_table_name}"."#{join_table_foreign_key}" =
                  #{relation_table_name}."#{relation.klass.primary_key}"
            WHERE "#{relation_join_table_name}"."#{relation.foreign_key}" =
              "#{table_name}"."#{self.primary_key}"
          )

          build_result(relation, fields, condition, relation_table_name, join_table_name: relation_join_table_name)
        end
      end
    end
  end
end