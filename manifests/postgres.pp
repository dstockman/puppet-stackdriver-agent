# == Class: stackdriver::postgres
# 
# Configures postgres agent for stackdriver-agent
#
# == Examples:
#
#  Redis plugin configuration
#  
#  class { 'stackdriver::postgres':
#    stackdriver_postgres_host    	=> "localhost",
#    stackdriver_postgres_port    	=> "5432",
#    stackdriver_postgres_password	=> undef,
#  }
class stackdriver::postgres ( 
  $stackdriver_postgres_port = 5432,
  $stackdriver_postgres_user = "stackdriver",
  $stackdriver_postgres_password = undef,
) {
  
  file { "/opt/stackdriver/collectd/etc/collectd.d/postgres.conf":
    ensure  => file,
    content => template("stackdriver/postgres.conf.erb"),
    owner   => root,
    group   => root,
    require => [ Package['stackdriver-agent'] ],
    notify  => Service['stackdriver-agent'],
  }
}
