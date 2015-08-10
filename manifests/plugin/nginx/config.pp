# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::nginx::config
#
# Configures Nginx Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::nginx::config(
) inherits stackdriver::plugin::nginx {

  file { $config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0440', # secure
  }

}

