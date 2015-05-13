# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::apache::config
#
# Configures Mongo Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::apache::config(


) inherits stackdriver::plugin::apache {

  file { $stackdriver::plugin::apache::config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${stackdriver::plugin::apache::config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0440', # secure
    notify  => Service[$::stackdriver::svc],
  }

}

