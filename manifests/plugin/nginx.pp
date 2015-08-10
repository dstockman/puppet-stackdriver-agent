# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::nginx
#
# Enable Nginx Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/nginx.conf (string - absolute path)
# - Plugin Configuration File
#
# [*url*]
# - Default - http://127.0.0.1/nginx_status (string - URI)
# - Target server URL
#
# [*user*]
# - Default - undef (string)
# - Target user
#
# [*password*]
# - Default - undef (string)
# - Target user password
#
# [*verifypeer*]
# - Default - undef (boolean)
# - Enable or disable peer SSL certificate verification
#
# [*verifyhost*]
# - Default - undef (boolean)
# - Enable or disable peer host name verification
#
# [*cacert*]
# - Default - undef (string - absolute path)
# - File that holds one or more SSL certificates
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Nginx plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::nginx'
#
# ==== Hiera
#
#  Enable Nginx plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'nginx'
#
class stackdriver::plugin::nginx(

  $config     =  '/opt/stackdriver/collectd/etc/collectd.d/nginx.conf',

  $url        = 'http://127.0.0.1/nginx_status',
  $user       = undef,
  $password   = undef,
  $verifypeer = undef,
  $verifyhost = undef,
  $cacert     = undef,

) {

  validate_absolute_path  ( $config )
  validate_string         ( $url    )

  if $user        != undef { validate_string        ( $user       ) }
  if $password    != undef { validate_string        ( $password   ) }
  if $verifypeer  != undef { validate_bool          ( $verifypeer ) }
  if $verifyhost  != undef { validate_bool          ( $verifyhost ) }
  if $cacert      != undef { validate_absolute_path ( $cacert     ) }

  contain "${name}::config"

  Class['::stackdriver::config'] ->
  Class["::${name}::config"] ~>
  Class['::stackdriver::service']

}

