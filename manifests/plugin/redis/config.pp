# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::redis::config
#
# Configures Redis Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::redis::config inherits stackdriver::plugin::redis {

  file { $stackdriver::plugin::redis::config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${stackdriver::plugin::redis::config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service[$::stackdriver::svc],
  }

}

