# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::memcached::config
#
# Configures Memcached Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::memcached::config inherits stackdriver::plugin::memcached {

  file { $stackdriver::plugin::memcached::config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${stackdriver::plugin::memcached::config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service[$::stackdriver::svc],
  }

}

