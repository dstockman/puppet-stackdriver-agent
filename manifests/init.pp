# == Class: stackdriver
#
# This module controls stackdriver-agent (www.stackdriver.com)
#
# == Examples:
#
#  Basic agent configuration
#
#  class { 'stackdriver':
#    stackdriver_apikey => "OMGBECKLOOKATHERBUTTITSJUSTSOROUND"
#  }
class stackdriver (
  $stackdriver_apikey = $stackdriver::params::stackdriver_apikey,
) inherits stackdriver::params {

  package { "stackdriver-agent": 
    ensure  => installed, 
    require => Yumrepo["stackdriver-agent"],
  }
  service { "stackdriver-agent": 
    ensure    => running, 
    enable    => true, 
    subscribe => File["/etc/sysconfig/stackdriver"], 
  }
  yumrepo { "stackdriver-agent":
    baseurl   => "http://repo.stackdriver.com/repo/el6/\$basearch/",
    gpgkey    => "https://www.stackdriver.com/RPM-GPG-KEY-stackdriver",
    descr     => "stackdriver",
    enabled   => 1,
    gpgcheck  => 1,
  }
  file { "/etc/sysconfig/stackdriver":
    ensure  => file,
    owner   => root,
    group   => root,
    content => template("stackdriver/stackdriver.erb"),
    require => Package["stackdriver-agent"],
  }
}
