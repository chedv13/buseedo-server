module JsonQuery
  module Associations
    module Builder
      module HasOne
        def build_has_one_query(relation)
          relation_table_name = relation.table_name

          %(
            (SELECT row_to_json(t)
            FROM (
              SELECT *
              FROM #{relation_table_name}
              WHERE "#{relation_table_name}"."#{relation.foreign_key}" = "#{self.table_name}"."#{relation.klass.primary_key}"
            ) t) AS #{relation.name}
          )
        end
      end
    end
  end
end
