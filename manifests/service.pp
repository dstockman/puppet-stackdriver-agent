class stackdriver::service{
  service { $stackdriver::svc:
    ensure => $stackdriver::service_ensure,
    enable => $stackdriver::service_enable,
  }
}
