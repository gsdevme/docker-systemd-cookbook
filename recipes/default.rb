include_recipe 'yum-docker'

package 'docker'

service "docker" do
  service_name "docker"
  supports enable: true, start: true, restart: true
  action [:enable, :start]
end

execute 'systemctl-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

node['docker-systemd']['containers'].each do |name, container_options|
  container_options = Chef::Mixin::DeepMerge.deep_merge(container_options, {
    name: name,
    timeout: 0,
    options: {},
    tag: 'latest',
    enable: true,
    start: true,
  })

  template "/etc/systemd/system/#{name}.service" do
    source 'systemd.service.erb'
    variables container_options
    mode '0755'
    # Reload the systemctl with the changes
    notifies :run, 'execute[systemctl-reload]', :delayed
    # Restart the container if its been changed
    notifies :restart, "service[#{name}]", :delayed
  end

  service name do
    service_name name
    supports enable: true, disable: true, start: true, restart: true
    action :nothing
  end

  if container_options['start']
    ruby_block "service control (#{name})" do
      block do
        r = resources(:service => name)
        [start].flatten.map(&:to_sym).each do |a|
          r.run_action a
        end
      end
      subscribes :run, "service[#{name}]", :delayed
      action :nothing
    end
  end

end


