# == Class: stackdriver::postgres
# 
# Configures postgres agent for stackdriver-agent
#
# == Examples:
#
#  postgres plugin configuration
#  
#  class { 'stackdriver::postgres':
#    stackdriver_postgres_user      => "stackdriver",
#    stackdriver_postgres_password	=> "passsword",
#    stackdriver_postgres_dbname    => "dbname",
#  }
class stackdriver::postgres ( 
  $stackdriver_postgres_user = "stackdriver",
  $stackdriver_postgres_password = undef,
  $stackdriver_postgres_dbname = undef,
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
