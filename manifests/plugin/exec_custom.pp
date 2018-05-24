# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::exec_custom
#
# Enable Custom Exec Agent Plugin for Stackdriver Agent
#
# KEY -- Your EXEC SCRIPT should output something similar to this:
# Example:
#   PUTVAL "ge-lxsjbsapi01/check_puppet-get_last_run/gauge-last_run_seconds" interval=60 1527190805:761
#           -------------- ------------ ------------ ----- ----------------              ---------- ---
#           \Hostname      \Plugin      \PluginType  \Type \TypeInstance                 \timestamp \Value
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/exec_custom.conf
# - Plugin configuration file
#
# [*rule*]
# - Default - undef 
# - Rule name, must be unique. 
#
# [*plugin*]
# - Default - undef 
# - Plugin name, see KEY above for proper output from EXEC script mapping. 
#
# [*plugin_instance*]
# - Default - undef 
# - Plugin Instance name, see KEY above for proper output from EXEC script mapping. 
#
# [*type*]
# - Default - guage 
# - Types.  gauge, delta, or cumulative 
# - https://cloud.google.com/monitoring/api/v3/metrics-details#metric-kinds
#
# [*type_instance*]
# - Default - undef 
# - Type Instance name, see KEY above for proper output from EXEC script mapping. 
#
# [*sd_metric_type*]
# - Default - undef 
# - What custom metric should get this data? Ex: custom.googleapis.com/puppet/last_run_total_events_success  
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

