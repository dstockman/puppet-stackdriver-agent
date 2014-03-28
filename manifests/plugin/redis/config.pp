# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::redis::config
#
# Configures Redis Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::redis::config inherits stackdriver::plugin::redis {

  file { $config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service[$::stackdriver::svc],
  }

}

