# puppet-stackdriver-agent

Installs stackdriver-agent.  Tested with AWS Linux 2013.03 with Puppet 2.7.21.  Patches for other distros welcomed.

## Usage

The stackdriver class includes the client

include stackdriver

You must specify your stackdriver api key:

class { "stackdriver::params":
   stackdriver_apikey => "OMGBECKYLOOKATHERBUTTITSJUSTSOBIG"
}

