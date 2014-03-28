# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::elasticsearch
#
# Enable Elasticsearch Agent Plugin for Stackdriver Agent
#
# {Stackdriver's Support Site}[http://feedback.stackdriver.com/knowledgebase/articles/268555-elasticsearch-plugin]
#
# === Parameters
# ---
#
# [*pkg*]
# - Default - Based on $::osfamily
# - List of package(s) to install
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/elasticsearch.conf
# - Plugin configuration file
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Elasticsearch plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::elasticsearch'
#
# ==== Hiera
#
#  Enable Elasticsearch plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'elasticsearch'
#
class stackdriver::plugin::elasticsearch(

  $pkg = $::osfamily ? {
    /(?i:Debian)/   => 'libyajl1',
    /(?i:RedHat)/   => 'yajl',
    default         => undef,
  },

  $config = '/opt/stackdriver/collectd/etc/collectd.d/elasticsearch.conf',

) {

  if $pkg { validate_string ( $pkg ) }
  validate_string ( $config )


  contain "${name}::install"

  class { "::${name}::config": require => Class["::${name}::install"] }
  contain "${name}::config"

}

