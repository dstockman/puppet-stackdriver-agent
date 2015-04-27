# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::zookeeper::config
#
# Configures Zookeeper Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::zookeeper::config(


) inherits stackdriver::plugin::zookeeper {

  file { $config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service[$::stackdriver::svc],
  }

}

