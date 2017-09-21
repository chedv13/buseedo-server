# == test
module JsonQuery
  module Associations
    module Builder
      include JsonQuery::Associations::Builder::BelongsTo
      include JsonQuery::Associations::Builder::HasAndBelongsToMany
      include JsonQuery::Associations::Builder::HasOne
      include JsonQuery::Associations::Builder::HasMany
      include JsonQuery::Associations::Builder::Through

      def build_query_for_relation(table_name, relation, fields)
        case relation.class.name
        when 'ActiveRecord::Reflection::BelongsToReflection'
          if relation.options.key?(:polymorphic)
            build_polymorphic_belongs_to_query(table_name, relation, fields)
          else
            build_belongs_to_query(table_name, relation)
          end
        when 'ActiveRecord::Reflection::HasAndBelongsToManyReflection'
          self.build_has_and_belongs_to_many_query(table_name, relation, fields)
        when 'ActiveRecord::Reflection::HasManyReflection'
          relation_table_name = relation.klass.table_name

          if relation.options.key?(:as)
            self.build_polymorphic_has_many_query(relation, relation_table_name, fields)
          else
            build_has_many_query(table_name, relation, relation_table_name, fields)
          end
        when 'ActiveRecord::Reflection::HasOneReflection'
          self.build_has_one_query(relation)
        when 'ActiveRecord::Reflection::ThroughReflection'
          self.build_through_query(relation, fields)
        else
          Rails.logger.info('Херня произошла в обработке связей')
        end
      end

      def build_result(relation, fields, condition, relation_name, join_table_name: nil)
        json_query = relation.klass.build_json_query(
            fields, condition: condition, join_table_name: join_table_name
        )

        %(
          (
            SELECT row_to_json(t) FROM (
              #{json_query}
            ) AS t
          ) AS #{relation_name}
        )
      end
    end
  end
end
