# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver
#
# This module manages the Stackdriver Agent (www.stackdriver.com)
#
# === Parameters
# ---
#
# [*apikey*]
# - Default - NONE (REQUIRED)
# - Stackdriver API key
#
# [*svc*]
# - Default - Depends on $::osfamily
# - Stackdriver Agent service name
#
# == Examples:
#
#  Basic agent configuration
#
#  class { 'stackdriver':
#    apikey => "OMGBECKYLOOKATHERBUTTITSJUSTSOROUND"
#  }
#
class stackdriver (

  $apikey = undef,
  $ensure = 'present',

  $svc = $::osfamily ? {
    'windows' => 'StackdriverAgent',
    'RedHat'  => 'stackdriver-agent',
    'Debian'  => 'stackdriver-agent',
    default   => undef,
  },

) {

  validate_string ( $apikey )
  validate_string ( $svc    )

  # Runtime class definitions
  $iclass = "${name}::install::${::osfamily}"
  $cclass = "${name}::config::${::osfamily}"
  $sclass = "${name}::service"


  # OS Family specific installation
  class { "::${iclass}":
    ensure => $ensure,
    notify => Class[$sclass],
  }
  contain $iclass


  # OS Family specific configuration
  class { "::${cclass}": require => Class[$iclass]; }
  contain $cclass


  # Service
  class { "::${sclass}": require => Class[$cclass]; }
  contain $sclass


  # Array of Plugins to load (optional)
  $plugins = hiera_array("${name}::plugins", [])

  if ! empty($plugins) {
    stackdriver::plugin { $plugins: }
  }

}

