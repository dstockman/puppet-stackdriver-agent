# == Class: stackdriver::nginx
# 
# Configures nginx agent for stackdriver-agent
#
# == Examples:
#
#  Redis plugin configuration
#  
#  class { 'stackdriver::nginx':
#    stackdriver_nginx_host    => "localhost",
#    stackdriver_nginx_port    => "6739",
#    stackdriver_nginx_timeout => "2000",
#  }
class stackdriver::nginx {
  

  file { "/opt/stackdriver/collectd/etc/collectd.d/nginx.conf":
    ensure  => file,
    content => template("stackdriver/nginx.conf.erb"),
    owner   => root,
    group   => root,
    require => [ Package['stackdriver-agent'] ],
    notify  => Service['stackdriver-agent'],
  }
}
