# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::config::redhat
#
# Configures Stackdriver Agent for RedHat derivatives
#
# === Parameters
#
# Use Hiera for overriding any parameter defaults
#
# ---
#
# [*sysconfig*]
# - Default - /etc/sysconfig/stackdriver
# - Stackdriver configuration file
#
class stackdriver::config::redhat(
  $apikey,
  $sysconfig = '/etc/sysconfig/stackdriver',
) {
  validate_string ( $sysconfig )

  file { $sysconfig:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',  # secure API key
    content => template("stackdriver/${::kernel}/${sysconfig}.erb"),
  }
}

