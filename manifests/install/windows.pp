# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::install::windows
#
# Installs Stackdriver Agent for Windows
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
# [*uninstallkey*]
# - Default - HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\StackdriverAgent
# - Registry uninstallation key created by an installed Stackdriver Agent
#
class stackdriver::install::windows(

  $installer    = '/tmp/Stackdriverinstaller-0.3.exe',
  $uninstallkey = 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\StackdriverAgent',

) inherits stackdriver {

  validate_string ( $installer    )
  validate_string ( $uninstallkey )

  if ! defined(File['C:/tmp']) {
    file { 'C:/tmp':
      ensure  => 'directory',
      mode    => '0775',
      owner   => 'SYSTEM',
      group   => 'Administrators',
    }
  }

  file { "C:${installer}":
    ensure  => file,
    owner   => 'SYSTEM',
    group   => 'Administrators',
    mode    => '0775',
    source  => "puppet:///modules/stackdriver/${::kernel}/${installer}",
    require => File['C:/tmp'];
  }

  exec {
    "${name}-installer":
      provider    => 'powershell',
      logoutput   => true,
      timeout     => 600,
      # NOTE: /S for silent install (API registry key will be empty)
      command     => "C:${installer} /S; Start-Sleep -s 30",
      unless      => "if(!(Test-Path \'${uninstallkey}\')) { exit 1 } else { exit 0 }",
      require     => File["C:${installer}"],
  }

}

