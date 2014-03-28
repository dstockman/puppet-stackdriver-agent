# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::elasticsearch::install
#
# Installs Elasticsearch Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::elasticsearch::install inherits stackdriver::plugin::elasticsearch {

  if ! $pkg {
    fail("No package defined for OS ${::operatingsystem}")
  }

  ensure_packages($pkg)

}
