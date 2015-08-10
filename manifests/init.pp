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
class stackdriver(
  $apikey         = undef,
  $ensure         = 'present',
  $service_ensure = 'running',
  $service_enable = true,
  $plugins        = [],
  $svc = $::osfamily ? {
    'RedHat'  => [ 'stackdriver-agent', 'stackdriver-extractor' ],
    'Debian'  => [ 'stackdriver-agent', 'stackdriver-extractor' ],
    default   => undef,
  },
  $iclass = "::stackdriver::install::${::osfamily}",
  $cclass = "::stackdriver::config::${::osfamily}",
) {
  validate_string ( $apikey )
  validate_array  ( $svc    )

  contain stackdriver::install
  contain stackdriver::config
  contain stackdriver::service

  Class['::stackdriver::install'] -> Class['::stackdriver::config']
  Class['::stackdriver::install'] ~> Class['::stackdriver::service'] 
  Class['::stackdriver::config'] ~> Class['::stackdriver::service'] 

  if ! empty($plugins) {
    stackdriver::plugin { $plugins: }
  }


}

