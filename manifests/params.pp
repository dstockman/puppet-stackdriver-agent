# General parameters for agent happiness
class stackdriver::params (
  $stackdriver_apikey = undef,
) { }

# Params for redis
class stackdriver::params::redis (
  $stackdriver_redis_port = 6379,
  $stackdriver_redis_host = localhost,
  $stackdriver_redis_timeout = 2000,
) { }

# Params for memcached
class stackdriver::params::memcached (
  $stackdriver_memcached_host = localhost,
  $stackdriver_memcached_port = 11211,
) { }

# Params for apache
class stackdriver::params::apache (
  $stackdriver_apache_url = undef,
  $stackdriver_apache_username = undef,
  $stackdriver_apache_password = undef,
) { } 

# Params for nginx
class stackdriver::params::nginx (
  $stackdriver_nginx_url = undef,
  $stackdriver_nginx_username = undef,
  $stackdriver_nginx_password = undef,
) { }

# Params for mysqld
class stackdriver::params::mysql (
  $stackdriver_mysql_host = localhost,
  $stackdriver_mysql_port = 3306,
  $stackdriver_mysql_timeout = undef,
  $stackdriver_mysql_username = yourmom,
  $stackdriver_mysql_password = yourface,
) { }