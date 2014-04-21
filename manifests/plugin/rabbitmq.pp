# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::rabbitmq
#
# Enable RabbitMQ Agent Plugin for Stackdriver Agent
#
# === Parameters
# ---
#
# [*config*]
# - Default - /opt/stackdriver/collectd/etc/collectd.d/rabbitmq.conf
# - Plugin configuration file
#
# [*vhost*]
# - Default - %2F
# - vhost needs to be url encoded, default vhost is "/"
#
# [*port*]
# - Default - 15672
# - management port, default to 15672
#
# [*queue*]
# - Default - undef (optional)
# - Queue name
#
# [*user*]
# - Default - guest
# - Target user
#
# [*password*]
# - Default - guest
# - Target user password
#
# === Usage
# ---
#
# ==== Puppet Code
#
#  Enable RabbitMQ plugin via Puppet CODE:
#
#  include '::stackdriver::plugin::rabbitmq'
#
# ==== Hiera
#
#  Enable RabbitMQ plugin via Hiera:
#
#  stackdriver::plugins:
#   - 'rabbitmq'
#
class stackdriver::plugin::rabbitmq(

  $config   =  '/opt/stackdriver/collectd/etc/collectd.d/rabbitmq.conf',
  $vhost    = '%2F',
  $port     = '15672',
  $queue    = undef,
  $user     = 'guest',
  $password = 'guest',

) {

  validate_string ( $config   )
  validate_string ( $vhost    )
  validate_string ( $port     )
  validate_string ( $user     )
  validate_string ( $password )
  validate_string ( $queue    )

  contain "${name}::config"

  # Install package
  ensure_resource('package', 'yajl', {
    'ensure'  => 'present',
  })

}

