module Keydom
  module Migration
    module CommandRecorder
      def add_primary_key(*args)
        record(:add_primary_key, args)
      end

      def remove_primary_key(*args)
        record(:remove_primary_key, args)
      end
      
      def invert_add_primary_key(*args)
        [:remove_primary_key, *args]
      end
    end
  end
end