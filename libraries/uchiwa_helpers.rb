module Uchiwa
  module Helpers

    def self.data_bag_item(data_bag_name, data_bag_item, missing_ok=false)

      Chef::EncryptedDataBagItem.load(data_bag_name, data_bag_item).to_hash.delete_if { |key, value| key == 'id' }

    rescue Chef::Exceptions::ValidationFailed,
        Chef::Exceptions::InvalidDataBagPath,
        Net::HTTPServerException => error
      missing_ok ? nil : raise(error)
    end

  end
end