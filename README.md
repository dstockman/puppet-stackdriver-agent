# puppet-stackdriver-agent

Installs stackdriver-agent.  Tested with AWS Linux 2013.03 with Puppet 2.7.22 and includes support for Debian/Ubuntu distributions which is untested.

## Usage

This module requires a Stackdriver account.  Free trial accounts are available at their [website](http://www.stackdriver.com/signup).

### Base Agent

The stackdriver class includes the client:

	include stackdriver

You must specify your stackdriver api key:

	class { "stackdriver::params":
	   stackdriver_apikey => "OMGBECKYLOOKATHERBUTTITSJUSTSOBIG",
	}

### Redis

Configures the redis plugin on the local host running on port 6739.  Note: this module requires hiredis-devel be available to the system.

	class { 'stackdriver::redis':
	  stackdriver_redis_host    => "localhost",
	  stackdriver_redis_port    => "6739",
	  stackdriver_redis_timeout => "2000",
	}

### MongoDB

Configures the MongoDB plugin on the local host running on port 27017.

	class { 'stackdriver::mongo':
    stackdriver_mongo_user       => "stackdriver",
    stackdriver_mongo_password   => "password",
    stackdriver_mongo_host       => "localhost",
    stackdriver_mongo_port       => "27017",
	}
	
### Postgresql

Configures the Postgreqsql plugin on the local host using UNIX domain sockets.  Prerequisites for this plugin are documented on Stackdriver's [support site](http://feedback.stackdriver.com/knowledgebase/articles/232555-postgresql-plugin).

	class { 'stackdriver::postgres':
	  stackdriver_postgres_user        => "stackdriver",
	  stackdriver_postgres_password    => "password",
	  stackdriver_postgres_dbname      => "dbname",
	}

### nginx

Configures the nginx plugin on the local host running on port 80.

	class { 'stackdriver::nginx':
	  stackdriver_nginx_user        => "stackdriver",
	  stackdriver_nginx_password    => "password",
	  stackdriver_nginx_url         => "http://127.0.0.1/nginx_status",
	}

## See Also

* Stackdriver Website: [http://www.stackdriver.com](http://www.stackdriver.com)
* Stackdriver Signup:  [http://www.stackdriver.com/signup](http://www.stackdriver.com/signup)


