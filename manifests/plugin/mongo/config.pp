# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::mongo::config
#
# Configures Mongo Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::mongo::config(


) inherits stackdriver::plugin::mongo {

  file { $config:
    ensure  => file,
    content => template("stackdriver/${::kernel}/${config}.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0440', # secure
    notify  => Service[$::stackdriver::svc],
  }

}

