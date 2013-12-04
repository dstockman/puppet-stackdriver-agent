# == Class: stackdriver::apache
#
# Configures apache agent for stackdriver-agent
#
# == Examples:
#
#  apache plugin configuration
#
#  class { 'stackdriver::apache':
#    stackdriver_apache_user     => 'stackdriver',
#    stackdriver_apache_password => 'password',
#    stackdriver_apache_url      => 'http://127.0.0.1/mod_status?auto',
#  }
class stackdriver::apache (
  $stackdriver_apache_user     = undef,
  $stackdriver_apache_password = undef,
  $stackdriver_apache_url      = 'http://127.0.0.1/mod_status?auto',
){

  file { '/opt/stackdriver/collectd/etc/collectd.d/apache.conf':
    ensure  => file,
    content => template('stackdriver/apache.conf.erb'),
    owner   => root,
    group   => root,
    require => Package['stackdriver-agent'],
    notify  => Service['stackdriver-agent'],
  }
}
