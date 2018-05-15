module Uchiwa
  module Helpers

    extend ChefVaultCookbook if Kernel.const_defined?("ChefVaultCookbook")
    def self.data_bag_item(data_bag_name, data_bag_item, missing_ok=false)

      case ChefVault::Item.data_bag_item_type(data_bag_name, data_bag_item)
      when :normal
        Chef::DataBagItem.load(data_bag_name, data_bag_item)
      when :encrypted
        raw_hash = Chef::DataBagItem.load(data_bag_name, data_bag_item)
        secret = Chef::EncryptedDataBagItem.load_secret
        Chef::EncryptedDataBagItem.new(raw_hash, secret)
      when :vault
        chef_vault_item(data_bag_name, data_bag_item)
      end

    rescue Chef::Exceptions::ValidationFailed,
        Chef::Exceptions::InvalidDataBagPath,
        Chef::Exceptions::InvalidDataBagItemID,
        Net::HTTPServerException => error
      missing_ok ? nil : raise(error)
    end

  end
end
