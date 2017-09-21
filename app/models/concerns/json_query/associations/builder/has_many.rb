module JsonQuery
  module Associations
    module Builder
      module HasMany
        def build_has_many_query(table_name, relation, relation_table_name, fields)
          foreign_key = relation.foreign_key
          condition = %( WHERE "#{relation_table_name}"."#{foreign_key}" = "#{table_name}"."id" )

          build_result(relation, fields, condition, relation_table_name)
        end

        def build_polymorphic_has_many_query(relation, relation_table_name, fields)
          table_name = self.table_name
          foreign_key = relation.foreign_key
          type = relation.type
          condition = %(
            WHERE "#{relation_table_name}"."#{foreign_key}" = "#{table_name}"."id" AND
              "#{relation_table_name}"."#{type}" = '#{self}'
          )

          build_result(relation, fields, condition, relation_table_name)
        end
      end
    end
  end
end