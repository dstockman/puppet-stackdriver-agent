# == Class: stackdriver::nginx
# 
# Configures nginx agent for stackdriver-agent
#
# == Examples:
#
#  nginx plugin configuration
#  
#  class { 'stackdriver::nginx':
#    stackdriver_nginx_user        => "stackdriver",
#    stackdriver_nginx_password    => "password",
#    stackdriver_nginx_url         => "http://127.0.0.1/nginx_status",
#  }
class stackdriver::nginx (
  $stackdriver_nginx_user = undef,
  $stackdriver_nginx_password = undef,
  $stackdriver_nginx_url = "http://127.0.0.1/nginx_status",
){

  file { "/opt/stackdriver/collectd/etc/collectd.d/nginx.conf":
    ensure  => file,
    content => template("stackdriver/nginx.conf.erb"),
    owner   => root,
    group   => root,
    require => [ Package['stackdriver-agent'] ],
    notify  => Service['stackdriver-agent'],
  }
}
