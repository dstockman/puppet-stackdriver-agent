# == Class: stackdriver::mongo
# 
# Configures mongo agent for stackdriver-agent
#
# == Examples:
#
#  Mongo plugin configuration
#  
#  class { 'stackdriver::mongo':
#    stackdriver_mongo_user       => "stackdriver",
#    stackdriver_mongo_password   => "password",
#    stackdriver_mongo_host       => "localhost",
#    stackdriver_mongo_port       => "27017",
#  }
class stackdriver::mongo ( 
  $stackdriver_mongo_user = "stackdriver",
  $stackdriver_mongo_password = undef,
  $stackdriver_mongo_host     = localhost,
  $stackdriver_mongo_port     = 27017,
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
