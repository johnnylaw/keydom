module Keydom
  class Railtie < Rails::Railtie
    initializer 'keydom.load_adapter' do
      ActiveSupport.on_load :active_record do
        Keydom.load
      end
    end
  end
end