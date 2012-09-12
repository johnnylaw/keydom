require 'active_support/all'

module Keydom
  extend ActiveSupport::Autoload
  autoload :Adapter
  autoload :SchemaDumper
  autoload :Base

  module ConnectionAdapters
    extend ActiveSupport::Autoload
    autoload :TableDefinition
    autoload :Sql2003

    autoload_under 'abstract' do
      autoload :SchemaDefinitions
      autoload :SchemaStatements
    end
  end

  module Migration
    autoload :CommandRecorder, 'keydom/migration/command_recorder'
  end
end

Keydom::Adapter.register 'postgresql', 'keydom/connection_adapters/postgresql_adapter'

require 'keydom/loader'
require 'keydom/railtie' if defined?(Rails)
