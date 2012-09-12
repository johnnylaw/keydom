module Keydom
  def self.load
    ActiveRecord::SchemaDumper.class_eval do
      include Keydom::SchemaDumper
    end

    ActiveRecord::Base.class_eval do
      include Keydom::Base
    end
    
    ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
      include Keydom::ConnectionAdapters::TableDefinition
    end

    if defined?(ActiveRecord::Migration::CommandRecorder)
      ActiveRecord::Migration::CommandRecorder.class_eval do
        include Keydom::Migration::CommandRecorder
      end
    end

    Keydom::Adapter.load!
  end
end