# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::redis
#
# Enable Redis Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*pkg*]
# - Default - hiredis-devel
# - List of package(s) to install
#
# [*conf*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/redis.conf
# - Plugin configuration file
#
# [*host*]
# - Default - localhost
# - Target host
#
# [*port*]
# - Default - 6379
# - Target port
#
# [*timeout*]
# - Default - 2000
# - Plugin timeout
#
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Redis plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::redis'
#
# ==== Hiera
#
#  Enable Redis plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'redis'
#
class stackdriver::plugin::redis(
  $pkg      = 'hiredis-devel',
  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/redis.conf',
  $host     = 'localhost',
  $port     = 6379,
  $timeout  = 2000,

) {

  validate_string ( $pkg    )
  validate_string ( $config )
  validate_string ( $host   )

  contain "${name}::install"
  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::install"] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']
}
