require 'active_support/concern'

# == Concern for json query generation from PostgreSQL
#
module JsonQuery
  module Builder
    extend ActiveSupport::Concern

    module ClassMethods
      include JsonQuery::Associations::Builder
      include JsonQuery::Associations::Validator

      def build_json_query(fields, join_table_name: nil, limit: 10, offset: 0, condition: '', relations_with_fields: {})
        table_name = self.table_name
        from_table_name = join_table_name ? join_table_name : table_name
        relations_query = relations_with_fields.empty? ? '' : self.build_relationships_query(relations_with_fields)

        query = %{
        SELECT
          #{build_data_query(table_name, fields, relations_query, from_table_name, condition, limit, offset)},
          #{build_meta_query(limit, from_table_name, condition)}
        }
        query
      end

      def build_data_query(table_name, fields, relations_query, res_table_name, condition, limit, offset)
        %(
          (
            SELECT
              CASE
                WHEN data IS NULL
                  THEN '[]'
                ELSE
                  data
              END
            FROM (
              SELECT json_agg(row_to_json(t)) AS data
              FROM (
                SELECT
                  attributes :: JSONB -> 'id' AS id,
                  '#{table_name}'                   AS type,
                  attributes :: JSONB - 'id'  AS attributes
                FROM (
                  SELECT row_to_json(t) AS attributes
                  FROM (
                    SELECT
                      "#{table_name}"."id",
                      #{fields.join(',')} #{relations_query}
                    FROM #{res_table_name} #{condition ? condition : ''}
                    LIMIT #{limit} #{offset > 0 ? "OFFSET #{offset}" : ''}
                  ) t
                ) t
              ) t
            ) t
          )
        )
      end

      def build_meta_query(limit, table_name, condition)
        %(
        (
          SELECT row_to_json(t)
          FROM (
            SELECT
              count,
              1                                    AS current_page,
              ceil((count / #{limit}.0) :: FLOAT) :: INT AS pages,
              #{limit}                                   AS per_page
            FROM (
              SELECT count(*) AS count
              FROM #{table_name} #{condition ? condition : ''}
            ) t
          ) t
        ) AS meta
      )
      end

      def build_relationships_query(relation_names_with_columns)
        relations = self.reflect_on_all_associations
        table_name = self.table_name
        relations_with_fields = select_valid_relations_and_fields(relations, relation_names_with_columns)
        relations_query = relations_with_fields.map do |relation, fields|
          build_query_for_relation(table_name, relation, fields)
        end.compact.join(',')

        if relations_query
          return %(
            ,
            (
              SELECT row_to_json(t) FROM (
                SELECT
                #{relations_query}
              ) t
            ) AS relationships
          )
        end

        relations_query
      end
    end
  end
end
