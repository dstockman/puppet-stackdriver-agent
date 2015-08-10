# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::apache
#
# Enable Apache Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/apache.conf
# - Plugin configuration file
#
# [*url*]
# - Default - http://127.0.0.1/mod_status?auto
# - Target server URL
#
# [*user*]
# - Default - undef (optional)
# - Target user
#
# [*password*]
# - Default - undef (optional)
# - Target user password
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Apache plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::apache'
#
# ==== Hiera
#
#  Enable Apache plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'apache'
#
class stackdriver::plugin::apache(
  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/apache.conf',
  $url      = 'http://127.0.0.1/mod_status?auto',
  $user     = undef,
  $password = undef,
) {

  validate_string ( $config )
  validate_string ( $url    )
  if $user      { validate_string ( $user     ) }
  if $password  { validate_string ( $password ) }

  contain "${name}::config"

  Class['::stackdriver::config'] -> 
  Class["::${name}::config"] ~> 
  Class['::stackdriver::service']

}

