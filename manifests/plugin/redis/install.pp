# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::redis::install
#
# Installs Redis Agent Plugin for Stackdriver Agent
#
class stackdriver::plugin::redis::install inherits stackdriver::plugin::redis {

  if ! $stackdriver::plugin::redis::pkg {
    fail("No package defined for OS ${::operatingsystem}")
  }

  ensure_packages([$stackdriver::plugin::redis::pkg])

}
