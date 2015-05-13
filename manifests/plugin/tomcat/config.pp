# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::plugin::tomcat::config
#
# Configures Tomcat Monitoring for Stackdriver Agent
#
class stackdriver::plugin::tomcat::config(


) inherits stackdriver::plugin::tomcat {

  require stackdriver::jmxtrans

  # Install Conf files
  file { '/mnt/jmxtrans/conf/tomcat-7.json':
    ensure  => $stackdriver::plugin::tomcat::ensure,
    content => template('stackdriver/tomcat/tomcat-7.json.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    before  => Service['jmxtrans'],
    notify  => Service['jmxtrans'],
  }
  file { '/mnt/jmxtrans/conf/tomcat-jvm-sun-hotspot.json':
    ensure  => $stackdriver::plugin::tomcat::ensure,
    content => template('stackdriver/tomcat/jvm-sun-hotspot.json.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    before  => Service['jmxtrans'],
    notify  => Service['jmxtrans'],
  }
}
