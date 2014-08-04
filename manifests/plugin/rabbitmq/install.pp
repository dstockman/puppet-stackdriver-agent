# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::rabbitmq::install
#
# Installs Rabbitmq Agent Plugin for Stackdriver Agent
#

class stackdriver::plugin::rabbitmq::install inherits stackdriver::plugin::rabbitmq {

  if ! $pkg {
    fail("No package defined for OS ${::operatingsystem}")
  }

  package { [$pkg]:
    ensure  => 'present', 
    require => [Package['yum-plugin-s3-iam'], 
                Package['stackdriver-agent']],
  }

}

