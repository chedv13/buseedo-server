module JsonQuery
  module Associations
    module Builder
      module BelongsTo
        def build_belongs_to_query(table_name, relation)
          relation_table_name = relation.active_record.table_name

          %{
            (
              SELECT row_to_json(t)
              FROM (
                SELECT *
                FROM #{relation_table_name}
                WHERE "#{table_name}"."#{relation.foreign_key}" =
                  "#{relation_table_name}"."#{relation.active_record.primary_key}"
              ) t
            ) AS #{relation.name}
          }
        end

        def build_polymorphic_belongs_to_query(table_name, relation, fields)
          case_for_query = build_case_for_polymorphic_belongs_to_query(
              relation, table_name, fields
          )

          %{
            (
              SELECT row_to_json(t)
              FROM (
                SELECT
                  attributes :: JSONB -> 'id' AS id,
                  attributes :: JSONB -> 'type' AS type,
                  attributes :: JSONB - 'id' - 'type' AS attributes
                FROM (
                  SELECT (
                    #{case_for_query}
                  ) AS attributes
                ) t
              ) t
            ) AS #{relation.name}
          }
        end

        def build_case_for_polymorphic_belongs_to_query(relation, table_name, fields)
          selected_ar_relations = ActiveRecord::Base.descendants.map { |x| x.reflect_on_all_associations }.flatten
                                      .select { |x| x.options.key?(:as) && x.options[:as] == relation.name }
          when_conditions = selected_ar_relations.map do |r|
            ar = r.active_record
            relation_table_name = ar.table_name
            relation_primary_key = ar.primary_key

            %(
              WHEN '#{ar}'
                THEN (
                  SELECT row_to_json(t)
                  FROM (
                    SELECT
                      id,
                      '#{relation_table_name}' AS type
                      #{fields[relation_table_name].empty? ? '' : ",#{fields[relation_table_name].join(',')}"}
                    FROM #{relation_table_name}
                    WHERE "#{table_name}"."#{relation.foreign_key}" =
                          "#{relation_table_name}"."#{relation_primary_key}"
                    LIMIT 1
                  ) t
                )
            )
          end

          %(
            CASE recipeable_type
              #{when_conditions.join(' ')}
            END
          )
        end
      end
    end
  end
end
