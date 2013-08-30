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
  $stackdriver_apikey = undef,
) {

	case $::operatingsystem {
		/(?i:CentOS|RedHat|Fedora|Amazon)/:  {
			yumrepo { "stackdriver-agent":
			baseurl   => "http://repo.stackdriver.com/repo/el6/\$basearch/",
			gpgkey    => "https://www.stackdriver.com/RPM-GPG-KEY-stackdriver",
			descr     => "stackdriver",
			enabled   => 1,
			gpgcheck  => 1,
			}

			service { "stackdriver-agent": 
				ensure    => running, 
				enable    => true, 
				subscribe => File["/etc/sysconfig/stackdriver"], 
			}

  		file { "/etc/sysconfig/stackdriver":
				ensure  => file,
				owner   => root,
				group   => root,
				content => template("stackdriver/stackdriver.erb"),
				require => Package["stackdriver-agent"],
			}

  		package { "stackdriver-agent": 
    		ensure  => installed, 
    		require => Yumrepo["stackdriver-agent"],
  		}
		}
		/(?i:Ubuntu|Debian)/: {
			exec { stackdriver-add-apt-key:
				unless  => "apt-key list | grep -q 2048R/7B190BD2",
				command => "apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 7B190BD2",
				path		=> ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			}
			exec { stackdriver-add-apt-repo:
				creates => "/etc/apt/sources.list.d/stackdriver.list",
				command => "wget -O /etc/apt/sources.list.d/stackdriver.list http://repo.stackdriver.com/precise.list",
				path		=> ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			}
			exec { stackdriver-apt-get-update:
				refreshonly => true,
				subscribe   => [Exec["stackdriver-add-apt-key"], Exec["stackdriver-add-apt-repo"]],
				command     => "apt-get update",
				path				=> ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			}

  		package { "stackdriver-agent": 
    		ensure  => installed, 
    		require => [Exec['stackdriver-apt-get-update'], File['/etc/default/stackdriver-agent']],
  		}

			service { "stackdriver-agent": 
				ensure    => running, 
				enable    => true, 
				subscribe => File["/etc/default/stackdriver-agent"], 
				require		=> Package['stackdriver-agent'],
			}

  		file { "/etc/default/stackdriver-agent":
				ensure  => file,
				owner   => root,
				group   => root,
				content => template("stackdriver/stackdriver.erb"),
			}
		}
	}
}
