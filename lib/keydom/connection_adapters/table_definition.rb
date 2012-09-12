module Keydom
  module ConnectionAdapters
    module TableDefinition
      def uuid *args
        options = args.extract_options!
        column_names = args
        type = :uuid
        column_names.each { |name| column(name, type, options) }
      end
    end
  end
end
