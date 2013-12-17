# == Class: stackdriver::elasticsearch
#
# Configures elasticsearch agent for stackdriver-agent
#
# == Examples:
#
#  Elasticsearch plugin configuration
#
#  class { 'stackdriver::elasticsearch':
#  }
class stackdriver::elasticsearch {

  file { '/opt/stackdriver/collectd/etc/collectd.d/elasticsearch.conf':
    ensure  => file,
    source  => 'puppet:///modules/stackdriver/elasticsearch.conf',
    owner   => root,
    group   => root,
    require => Package['stackdriver-agent','yajl'],
    notify  => Service['stackdriver-agent'],
  }

  package { 'yajl':
    ensure  => installed,
    name    => $::operatingsystem ? {
      /(?i:Ubuntu|Debian)/                => 'libyajl1',
      /(?i:CentOS|RedHat|Fedora|Amazon)/  => 'yajl',
    }
  }
}
