default[:kafka][:user] = "kafka"
default[:kafka][:group] = "kafka"

default[:kafka][:install_dir] = "/opt/kafka"
default[:kafka][:tmp_dir] = "/tmp"
default[:kafka][:version] = "0.7.2"

default[:kafka][:log4j_dir] = "/var/log/kafka"
default[:kafka][:log_level] = "INFO"

default[:kafka][:broker_id] = node[:ipaddress].gsub('.', '')
default[:kafka][:hostname] = nil
default[:kafka][:port] = 9092
default[:kafka][:num_threads] = nil
default[:kafka][:socket_send_buffer] = 1048576
default[:kafka][:socket_receive_buffer] = 1048576
default[:kafka][:max_socket_request_bytes] = 104857600
default[:kafka][:log_dir] = "/opt/kafka/logs"
default[:kafka][:num_partitions] = 1
default[:kafka][:log_flush_interval] = 10000
default[:kafka][:log_default_flush_interval_ms] = 1000
default[:kafka][:log_default_flush_scheduler_interval_ms] = 1000
default[:kafka][:log_retention_hours] = 168
default[:kafka][:log_file_size] = 536870912
default[:kafka][:log_cleanup_interval_mins] = 1
default[:kafka][:zk_connect] = []
default[:kafka][:zk_connectiontimeout_ms] = 1000000

default[:kafka][:jmx_port] = 9999
default[:kafka][:heap_opts] = "-Xmx1G -Xms1G"
