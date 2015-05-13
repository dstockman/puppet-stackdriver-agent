class stackdriver::jmxtrans(

  $pkg = $::osfamily ? {
    /(?i:Debian)/   => 'stackdriver-jmxtrans-all',
    default         => undef,
  },

  $ppa = 'ppa:morten-hekkvang/stackdriver-jmxtrans-all',

  $sysconfig = {},

) {
  # We need to use this special version of jmxtrans to be able to send
  # metrics to the Google Cloud Monitoring servers.
  if $sysconfig { validate_hash ( $sysconfig ) }

  if $pkg { validate_string ( $pkg ) }

  if ! $pkg {
    fail("No package defined for OS ${::operatingsystem}")
  }

  if $ppa {
    validate_string( $ppa )

    # Add the apt ppa
    apt::ppa { $ppa: }
  }

  # Install package
  package { $pkg:
    ensure => 'installed',
    before => Service['jmxtrans'],
    notify => Service['jmxtrans'],
  }

  # Install init script
  file { '/etc/init.d/jmxtrans':
    ensure => 'present',
    source => 'puppet:///modules/stackdriver/jmxtrans/initd-jmxtrans',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    before => Service['jmxtrans'],
    notify => Service['jmxtrans'],
  }

  file { '/etc/sysconfig':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0640'
  }

  # Overrides via /etc/sysconfig/jmxtrans
  file { '/etc/sysconfig/jmxtrans':
    ensure  => 'present',
    content => template('stackdriver/jmxtrans/sysconfig-jmxtrans.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    before  => Service['jmxtrans'],
    notify  => Service['jmxtrans'],
  }

  service { 'jmxtrans':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/jmxtrans'],
  }
}
