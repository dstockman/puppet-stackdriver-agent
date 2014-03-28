# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Define: stackdriver::plugin
#
# Loads a Plugin for the Stackdriver Agent
#
#   NOTE: plugin configuration parameters should be defined via Hiera
#
# === Parameters
# ---
#
# [*name*]
# - Default - NONE (REQUIRED)
# - Stackdriver plugin name
#
# == Examples:
#
#  stackdriver::plugin { 'elasticsearch': }
#
define stackdriver::plugin() {

  $pclass = "::stackdriver::plugin::${name}"

  if ! defined($pclass) {
    fail("Unknown Stackdriver Agent plugin ${name}")
  }

  include $pclass

}

