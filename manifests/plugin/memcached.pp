# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::memcached
#
# Enable Memcached Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*conf*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/memcached.conf
# - Plugin configuration file
#
# [*host*]
# - Default - localhost
# - Target host
#
# [*port*]
# - Default - 11211
# - Target port
#
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Memcached plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::memcached'
#
# ==== Hiera
#
#  Enable Memcached plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'memcached'
#
class stackdriver::plugin::memcached(

  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/memcached.conf',
  $host     = 'localhost',
  $port     = 11211,

) {

  validate_string ( $config )
  validate_string ( $host   )

  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']

}

