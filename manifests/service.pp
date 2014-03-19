# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::service
#
# Manages Stackdriver Agent Service
#
class stackdriver::service inherits stackdriver {

  service { $svc:
      ensure    => running,
      enable    => true,
  }

}

