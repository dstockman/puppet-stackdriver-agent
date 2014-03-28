# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::config::windows
#
# Configures Stackdriver Agent for Windows derivatives
#
# === Parameters
#
# Use Hiera for overriding any parameter defaults
#
# ---
#
# [*installer*]
# - Default - /tmp/Stackdriverinstaller-0.3.exe
# - Stackdriver Windows installer
#
# [*installkey*]
# - Default - HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\StackdriverAgent
# - Registry uninstallation key created by an installed Stackdriver Agent
#
class stackdriver::config::windows(
  $apiregkey  = 'HKLM:\Software\Wow6432Node\Stackdriver\Agent',
) inherits stackdriver {

  registry::value {
    "${name}-apiregkey":
      key     => $apiregkey,
      value   => 'ApiKey',
      type    => 'string',
      data    => $apikey,
      notify  => Service[$svc];
  }

}

