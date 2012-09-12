module Keydom
  module ConnectionAdapters
    module Sql2003
      def add_primary_key(table, columns)
        cols = [columns].flatten.map{ |col| quote_column_name(col) }
        execute "ALTER TABLE #{quote_table_name(table)} ADD PRIMARY KEY (#{cols.join(',')})"
      end

      def remove_primary_key(table, columns = nil)
        constraint = quote_column_name "#{table}_pkey"
        execute "ALTER TABLE #{quote_table_name(table)} " +
                "DROP CONSTRAINT #{constraint}"
      end
    end
  end
end