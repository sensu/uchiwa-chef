action :create do
  datacenter = {}
  datacenter[:name] = new_resource.name unless new_resource.name.nil?
  datacenter[:host] = new_resource.host
  datacenter[:port] = new_resource.port
  datacenter[:ssl] = new_resource.ssl
  datacenter[:insecure] = new_resource.insecure
  datacenter[:path] = new_resource.path unless new_resource.path.nil?
  datacenter[:timeout] = new_resource.timeout
  datacenter[:user] = new_resource.user unless new_resource.user.nil?
  datacenter[:pass] = new_resource.pass unless new_resource.pass.nil?

  node.run_state[:uchiwa_datacenters] ||= []
  node.run_state[:uchiwa_datacenters] << datacenter
end
