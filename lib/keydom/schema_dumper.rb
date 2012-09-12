module Keydom
  module SchemaDumper
    extend ActiveSupport::Concern

    included do
      alias_method_chain :table, :primary_key
    end
    
    def table_with_primary_key(table, stream)
      tbl = StringIO.new
      table_without_primary_key(table, tbl)
      primary_key(table, stream, tbl)
    end

    private
      def primary_key(table_name, stream, tbl)
        tbl.rewind
        if (primary_key = @connection.added_primary_key(table_name))
          stream.puts tbl.read.sub(/\n\n$/, "\n")
          stream.puts "  add_primary_key #{table_name.inspect}, #{primary_key.inspect}"
          stream.puts
          return
        end
        stream.puts tbl.read
      end
  end
end
