actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :host, :kind_of => String, :default => "127.0.0.1"
attribute :port, :kind_of => Integer, :default => 4567
attribute :ssl, :kind_of => [TrueClass, FalseClass], :default => false
attribute :insecure, :kind_of => [TrueClass, FalseClass], :default => false
attribute :path, :kind_of => String
attribute :timeout, :kind_of => Integer, :default => 5
attribute :user, :kind_of => String
attribute :pass, :kind_of => String
