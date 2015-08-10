# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::postgres
#
# Enable Postgres Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/postgres.conf
# - Plugin Configuration File
#
# [*dbname*]
# - Default - NONE (REQUIRED)
# - Target database name
#
# [*user*]
# - Default - stackdriver
# - Target user
#
# [*password*]
# - Default - xoiboov9Pai5e
# - Target user password
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Postgres plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::postgres'
#
# ==== Hiera
#
#  Enable Postgres plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'postgres'
#
class stackdriver::plugin::postgres(
  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/postgres.conf',
  $dbname   = undef,  # REQUIRED Param
  $user     = 'stackdriver',
  $password = 'xoiboov9Pai5e',
) {

  validate_string ( $config   )
  validate_string ( $dbname   )
  validate_string ( $user     )
  validate_string ( $password )

  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']

}

