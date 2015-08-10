# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::zookeeper
#
# Enable Zookeeper Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/zookeeper.conf
# - Plugin configuration file
#
# [*host*]
# - Default - localhost
# - Zookeeper instance host
#
# [*port*]
# - Default - 2181
# - Zookeeper instance port
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Zookeeper plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::zookeeper'
#
# ==== Hiera
#
#  Enable Zookeeper plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'zookeeper'
#
class stackdriver::plugin::zookeeper(

  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/zookeeper.conf',
  $host     =  'localhost',
  $port     =  '2181'

) {

  validate_string ( $config )
  validate_string ( $host   )
  validate_string ( $port   )

  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']

}

