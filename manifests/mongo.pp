# == Class: stackdriver::mongo
# 
# Configures mongo agent for stackdriver-agent
#
# == Examples:
#
#  Redis plugin configuration
#  
#  class { 'stackdriver::mongo':
#    stackdriver_mongo_host    => "localhost",
#    stackdriver_mongo_port    => "6739",
#    stackdriver_mongo_timeout => "2000",
#  }
class stackdriver::mongo ( 
  $stackdriver_mongo_user = "stackdriver",
  $stackdriver_mongo_password = undef,
) {
  
  file { "/opt/stackdriver/collectd/etc/collectd.d/mongo.conf":
    ensure  => file,
    content => template("stackdriver/mongo.conf.erb"),
    owner   => root,
    group   => root,
    require => Package['stackdriver-agent'],
    notify  => Service['stackdriver-agent'],
  }
}
