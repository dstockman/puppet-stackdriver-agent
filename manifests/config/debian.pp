# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::config::debian
#
# Configures Stackdriver Agent for Debian derivatives
#
# === Parameters
#
# Use Hiera for overriding any parameter defaults
#
# ---
#
# [*sysconfig*]
# - Default - /etc/default/stackdriver-agent
# - Stackdriver configuration file
#
class stackdriver::config::debian(
  $apikey, 
  $sysconfig = '/etc/default/stackdriver-agent',
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
