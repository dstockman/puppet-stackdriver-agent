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
# - Default - /opt/stackdriver/collectd/etc/collectd.d/nginx.conf
# - Plugin Configuration File
#
# [*url*]
# - Default - http://127.0.0.1/nginx_status
# - Target server URL
#
# [*user*]
# - Default - stackdriver
# - Target user
#
# [*password*]
# - Default - Eef3haeziqu3j
# - Target user password
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

  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/nginx.conf',

  $url      = 'http://127.0.0.1/nginx_status',
  $user     = 'stackdriver',
  $password = 'Eef3haeziqu3j',

) {

  validate_string ( $config   )
  validate_string ( $url      )
  validate_string ( $user     )
  validate_string ( $password )

  #contain "${name}::install"

  #class { "::${name}::config": require => Class["::${name}::install"] }
  contain "${name}::config"

}

