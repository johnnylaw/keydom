module Keydom
  module ConnectionAdapters
    module PostgreSQLAdapter
      include Keydom::ConnectionAdapters::Sql2003

      def self.included(base)
        base.class_eval do
          alias_method_chain :native_database_types, :uuid_support
        end
      end

      def added_primary_key(table_name)
        return if pk_and_sequence_for(table_name)
        pk_info = select_all %{
          SELECT a.attname AS column, a.atttypid AS type_oid
          FROM pg_constraint c
          JOIN pg_class t ON c.conrelid = t.oid
          JOIN pg_attribute a ON a.attnum = any(c.conkey) AND a.attrelid = t.oid
          WHERE c.contype='p'
          AND t.relname='#{table_name}'
        }
        return if pk_info.empty?
        pk_info.map{ |row| row['column'] }
      end
      
      def native_database_types_with_uuid_support
        native_database_types_without_uuid_support.merge uuid: { name: 'uuid' }
      end
    end
    
    module PostgreSQLColumn
      def self.included(base)
        base.class_eval do
          alias_method_chain :simplified_type, :uuid_support
        end
      end
      
      private 
      
      def simplified_type_with_uuid_support(field_type)
        return :uuid if field_type == 'uuid'
        simplified_type_without_uuid_support field_type
      end
      
    end
  end
end

[:PostgreSQLAdapter, :JdbcAdapter].each do |adapter|
  begin
    ActiveRecord::ConnectionAdapters.const_get(adapter).class_eval do
      include Keydom::ConnectionAdapters::PostgreSQLAdapter
    end
  rescue
  end
end
ActiveRecord::ConnectionAdapters::PostgreSQLColumn.class_eval do
  include Keydom::ConnectionAdapters::PostgreSQLColumn
end
