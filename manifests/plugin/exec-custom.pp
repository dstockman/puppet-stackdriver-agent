# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::exec-custom
#
# Enable Custom Exec Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/exec-custom.conf
# - Plugin configuration file
#
# [*vhost*]
# - Default - %2F
# - vhost needs to be url encoded, default vhost is "/"
#
# [*port*]
# - Default - 15672
# - management port, default to 15672
#
# [*queue*]
# - Default - undef (optional)
# - Queue name
#
# [*user*]
# - Default - guest
# - Target user
#
# [*password*]
# - Default - guest
# - Target user password
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Exec Custom plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::exec-custom'
#
# ==== Hiera
#
#  Enable Exec Custom plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'exec-custom'
#
class stackdriver::plugin::exec-custom(

  $config           =  '/opt/stackdriver/collectd/etc/collectd.d/exec-custom.conf',
  $rule             = undef,
  $plugin           = undef, 
  $plugin_instance  = undef, 
  $type             = 'gauge',
  $type_instance    = undef, 
  $sd_metric_type   = undef, 
  $custom_rules     = [{},],

) {

  Class['stackdriver'] -> Class[$name]

  validate_array  ( $custom_rules )

  contain "${name}::config"

  # Install package
  #ensure_resource('package', 'yajl', {
  #  'ensure'  => 'present',
  #})

}

