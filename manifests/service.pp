# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::service
#
# Manages Stackdriver Agent Service
#
class stackdriver::service(
  $service_ensure = 'running',
  $service_enable = 'true',
  ) inherits stackdriver {

    service { $svc:
      ensure    => $service_ensure,
      enable    => $service_enable,
  }

}

