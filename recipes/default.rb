group node[:kafka][:group]

user node[:kafka][:user] do
  gid      node[:kafka][:group]
  shell    "/sbin/nologin"
  supports :manage_home => false
end

distrib_name = "kafka-#{node[:kafka][:version]}-incubating-src"
archive_name = "#{distrib_name}.tgz"
archive_path = ::File.join(node[:kafka][:tmp_dir], archive_name)
source_dir   = ::File.join(node[:kafka][:tmp_dir], distrib_name)

server_config_path = ::File.join(node[:kafka][:install_dir], "config", "server.properties")
log4j_config_path  = ::File.join(node[:kafka][:install_dir], "config", "log4j.properties")

env_path  = "/etc/default/kafka"
init_path = "/etc/init/kafka.conf"

remote_file archive_path do
  source "http://archive.apache.org/dist/kafka/old_releases/kafka-#{node[:kafka][:version]}-incubating/#{archive_name}"
  mode   "0644"
end

execute "Extract tarball" do
  user    "root"
  group   "root"
  cwd     node[:kafka][:tmp_dir]
  command "tar --no-same-owner -xzf #{archive_path}"
  not_if  { ::File.exist?(source_dir) }
end

execute "Compile Kafka" do
  user    "root"
  group   "root"
  cwd     source_dir
  command "bash sbt update package"
  only_if { ::File.exist?(source_dir) }
end

directory node[:kafka][:install_dir] do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

execute "Copy Kafka to install directory" do
  user    "root"
  group   "root"
  command "rsync -a #{source_dir}/ #{node[:kafka][:install_dir]}/"
  not_if  { ::File.exist?(File.join(node[:kafka][:install_dir], "bin")) }
end

[node[:kafka][:log_dir], node[:kafka][:log4j_dir]].each do |dir|
  directory dir do
    owner     node[:kafka][:user]
    group     node[:kafka][:group]
    mode      "0755"
    recursive true
  end
end

template log4j_config_path do
  source "log4j.properties.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

template server_config_path do
  source "server.properties.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

template env_path do
  source "env.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables(
    :log4j_config_path  => log4j_config_path,
    :server_config_path => server_config_path
  )
end

template init_path do
  source "init.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables(
    :env_path => env_path
  )
end

service "kafka" do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :stop => true, :restart => true
  action   :enable
end
