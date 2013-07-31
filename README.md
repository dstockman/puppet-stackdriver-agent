# puppet-stackdriver-agent

Installs stackdriver-agent.  Tested with AWS Linux 2013.03 with Puppet 2.7.22.  Patches for other distros welcomed.

## Usage

This module requires a Stackdriver account.  Free trial accounts are available at their [website](http://www.stackdriver.com/signup).

### Base Agent

The stackdriver class includes the client:

	include stackdriver

You must specify your stackdriver api key:

	class { "stackdriver::params":
	   stackdriver_apikey => "OMGBECKYLOOKATHERBUTTITSJUSTSOBIG"
	}

### Redis

To configure the redis plugin on the local host running on port 6739.  Note: this module requires hiredis-devel be available to the system.

	class { 'stackdriver::redis':
	  stackdriver_redis_host    => "localhost",
	  stackdriver_redis_port    => "6739",
	  stackdriver_redis_timeout => "2000",
	}

## See Also

* Stackdriver Website: [http://www.stackdriver.com](http://www.stackdriver.com)
* Stackdriver Signup:  [http://www.stackdriver.com/signup](http://www.stackdriver.com/signup)


