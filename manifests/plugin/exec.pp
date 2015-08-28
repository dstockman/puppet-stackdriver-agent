# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::exec
#
# Enable Exec Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/exec.conf
# - Plugin configuration file
#
# [*usehost*]
# - Default - False
# - Send hostname along with metric
#
# [*interval*]
# - Default - 60
# - Exec frequency
#
# [*metric*]
# - Default - None
# - Metric (StackDriver namespace) to store datapoint to.  REQUIRED.
#
# [*type*]
# - Default - 'count'
# - Metric type (from /opt/stackdriver/collectd/share/collectd/types.db)
#
# [*command*]
# - Default - None
# - Command to Exec to generate the *metric* datapoint.  REQUIRED.
#
# [*tsr*]
# - Default - False
# - Instead of running once and emitting a single metric datapoint, enter a
#   loop where *command* is run every *interval* to emit a *metric* datapoint
#
# === Usage
# ---
#
# ==== Hiera
#
#  Enable Exec plugin via Hiera:
#
#  stackdriver::plugins:
#   - exec
#
# ==== Puppet Code
#
#  Enable Exec plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::exec'
#
class stackdriver::plugin::exec(

  $config   = '/opt/stackdriver/collectd/etc/collectd.d/exec.conf',
  $usehost  = false,
  $interval = 60,
  $metric   = undef,
  $type     = 'count',
  $command  = undef,
  $tsr      = false,

) {

  Class['stackdriver'] -> Class[$name]

  validate_absolute_path  ( $config   )
  validate_string         ( $bool     )
  validate_integer        ( $interval )
  validate_string         ( $metric   )
  validate_string         ( $type     )
  validate_string         ( $command  )
  validate_bool           ( $tsr      )

  contain "${name}::config"

}

