# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
class stackdriver::plugin::kafka(
  $host      = 'localhost',
  $port      = '7199',
  $apikey    = hiera('stackdriver::apikey'),
) {

  Class['stackdriver'] -> Class[$name]

  validate_string ( $host   )
  validate_string ( $port   )

  contain stackdriver::jmxtrans

  contain "${name}::config"

}
