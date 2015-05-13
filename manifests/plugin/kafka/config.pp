# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::kafka::config
#
# Configures Jmxtrans to collect metrics for Kafka and send to GCM Stackdriver
#
class stackdriver::plugin::kafka::config(


) inherits stackdriver::plugin::kafka {
  # Install Conf files
  file { '/mnt/jmxtrans/conf/kafka.json':
    ensure  => 'present',
    content => template('stackdriver/kafka/kafka.json.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    before  => Service['jmxtrans'],
    notify  => Service['jmxtrans'],
  }
}

