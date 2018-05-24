# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::exec_custom
#
# Enable Custom Exec Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/exec_custom.conf
# - Plugin configuration file
#
# [*vhost*]
# - Default - %2F
# - vhost needs to be url encoded, default vhost is "/"
#
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Exec Custom plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::exec_custom'
#
# ==== Hiera
#
#  Enable Exec Custom plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'exec_custom'
#
class stackdriver::plugin::exec_custom(

  $config           = '/opt/stackdriver/collectd/etc/collectd.d/exec_custom.conf',
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

