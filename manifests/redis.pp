# == Class: stackdriver::redis
# 
# Configures redis agent for stackdriver-agent
#
# == Examples:
#
#  Redis plugin configuration
#  
#  class { 'stackdriver::redis':
#    stackdriver_redis_host    => "localhost",
#    stackdriver_redis_port    => "6739",
#    stackdriver_redis_timeout => "2000",
#  }
class stackdriver::redis ( 
  $stackdriver_redis_port = 6379,
  $stackdriver_redis_host = localhost,
  $stackdriver_redis_timeout = 2000,
) {
  
  package { "hiredis-devel":
    ensure   => installed,
  }

  file { "/opt/stackdriver/collectd/etc/collectd.d/redis.conf":
    ensure  => file,
    content => template("stackdriver/redis.conf.erb"),
    owner   => root,
    group   => root,
    require => [ Package['stackdriver-agent'], Package['hiredis-devel'], ],
    notify  => Service['stackdriver-agent'],
  }
}
