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
# - Default - NONE (REQUIRED unless using gcm)
# - Stackdriver API key
#
# [*svc*]
# - Default - Depends on $::osfamily
# - Stackdriver Agent service name
#
# [*managerepo*]
# - Default - true
# - Should we add the upstream repository to the apt/Yum sources list?
#
# [*gcm*]
# - Default - false
# - Should we enable DETECT_GCM instead of using an API key?
# == Examples:
#
#  Basic agent configuration
#
#  class { 'stackdriver':
#    apikey => "OMGBECKYLOOKATHERBUTTITSJUSTSOROUND"
#  }
#
#  GCM agent configuration 
#
#  class { 'stackdriver':
#    gcm => true
#  }
#
class stackdriver (

  $apikey = undef,
  $ensure = 'present',
  $managerepo = true,
  $service_ensure = 'running',
  $service_enable = true,
  $gcm = false,

  $svc = $gcm ? {
    true    => $::osfamily ? {
      'RedHat'  => [ 'stackdriver-agent' ],
      'Debian'  => [ 'stackdriver-agent' ],
      default   => undef,
    },
    default => $::osfamily ? {
      'RedHat'  => [ 'stackdriver-agent', 'stackdriver-extractor' ],
      'Debian'  => [ 'stackdriver-agent', 'stackdriver-extractor' ],
      default   => undef,
    },
  },
  
  $svc_disable = $gcm ? {
    true    => $::osfamily ? {
      'RedHat'  => [ 'stackdriver-extractor' ],
      'Debian'  => [ 'stackdriver-extractor' ],
      default   => []
    },
    default => []
  },
) {

  validate_string ( $apikey )
  validate_array  ( $svc    )

  # Runtime class definitions
  $iclass = downcase("${name}::install::${::osfamily}")
  $cclass = downcase("${name}::config::${::osfamily}")
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
  class { "::${sclass}":
    service_ensure => $service_ensure,
    service_enable => $service_enable,
    require        => Class[$cclass],
  }
  include $sclass

  # Array of Plugins to load (optional)
  $plugins = hiera_array("${name}::plugins", [])

  if ! empty($plugins) {
    stackdriver::plugin { $plugins: }
  }

}

