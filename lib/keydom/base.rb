require 'uuidtools'
module Keydom
  module Base
    include UUIDTools
    DEFAULT_UUID_PK_OPTIONS = { client_assignable: true }

    def self.included(base)
      base.class_eval do
        def self.uses_uuid_primary_key *args
          column_name = args.first if args.first.is_a?(String) || args.first.is_a?(Symbol)
          column_name ||= :uuid
          options = args.last.is_a?(Hash) ? args.last : {}
          options = options.reverse_merge DEFAULT_UUID_PK_OPTIONS
          set_primary_key column_name
          attr_writer :id
          before_validation :set_pk_value_if_none

          if options[:client_assignable]
            attr_accessible column_name
            self.class_eval <<-EORUBY, __FILE__, __LINE__ + 1
              def #{column_name}=(arg)
                begin
                  UUID.parse arg.to_s
                  set_pk_value_if_none arg
                rescue ArgumentError
                end
              end
            EORUBY
          else
            self.class_eval <<-EORUBY, __FILE__, __LINE__ + 1
              def #{column_name}=(arg); end
            EORUBY
          end
            
          self.class_eval <<-EORUBY, __FILE__, __LINE__ + 1
            private
            
            def set_pk_value_if_none(value = nil)
              if read_attribute(:#{column_name}).nil?
                write_attribute :#{column_name}, value || UUID.random_create.to_s
              end
            end
          EORUBY
        end
      end
    end    
  end
end
ActiveRecord::Base.send :include, Keydom::Base