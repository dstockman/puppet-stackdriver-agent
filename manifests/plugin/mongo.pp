# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::mongo
#
# Enable Mongo Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/mongo.conf
# - Plugin configuration file
#
# [*host*]
# - Default - localhost
# - Target host
#
# [*port*]
# - Default - 27017
# - Target port
#
# [*user*]
# - Default - stackdriver
# - Target user
#
# [*password*]
# - Default - ahzae8aiLiKoe
# - Target user password
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Mongo plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::mongo'
#
# ==== Hiera
#
#  Enable Mongo plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'mongo'
#
class stackdriver::plugin::mongo(
  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/mongo.conf',
  $host     = 'localhost',
  $port     = 27017,
  $user     = 'stackdriver',
  $password = 'ahzae8aiLiKoe',
) {

  validate_string ( $config   )
  validate_string ( $host     )
  validate_string ( $user     )
  validate_string ( $password )

  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']

}

