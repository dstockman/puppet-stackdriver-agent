# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::tomcat
#
# Configure Stackdriver to monitor Tomcat
# http://feedback.stackdriver.com/knowledgebase/articles/244387-tomcat-monitoring
#
# === Parameters
# ---
#
# [*ensure*]
# - Default - present
# - Install or Remove all jmxtrans config files
#
# [*host*]
# - Default - localhost
# - Tomcat JMX Host
#
# [*port*]
# - Default - 9991
# - Tomcat JMX Port
#
# [*apikey*]
# - Default - retrieve from hiera stackdriver::apikey
# - Stackdriver API Key
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable Tomcat monitoring via Puppet CODE:
#
#  include '::stackdriver::plugin::tomcat'
#
# ==== Hiera
#
#  Enable Tomcat monitoring via Hiera:
#
#  stackdriver::plugins:
#   - 'tomcat'
#
class stackdriver::plugin::tomcat(
  $ensure    = 'present',
  $host      = 'localhost',
  $port      = '9991',
) {

  Class['stackdriver'] -> Class[$name]

  validate_string ( $ensure )
  validate_string ( $host   )
  validate_string ( $port   )

  contain "${name}::config"

}
