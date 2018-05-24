# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::exec_custom::config
#
# Configures Exec Custom Plugin for Stackdriver Agent
#
class stackdriver::plugin::exec_custom::config(

) inherits stackdriver::plugin::exec_custom {

  file { $config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0440', # secure
    notify  => Service[$::stackdriver::svc],
  }

}

