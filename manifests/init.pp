class stackdriver (
  $stackdriver_apikey = $stackdriver::params::stackdriver_apikey ) {

  package { "stackdriver-agent": ensure => installed, }
  service { "stackdriver-agent": ensure => running, enable => true, subscribe => File["/etc/sysconfig/stackdriver"], }

  exec { "getRepo":
    command => "curl -o /etc/yum.repos.d/stackdriver.repo http://repo.stackdriver.com/stackdriver-amazonlinux.repo",
    path => '/bin:/usr/bin',
    before => Package["stackdriver-agent"],
    onlyif => "test ! -f /etc/yum.repos.d/stackdriver.repo"
  }

  file { "/etc/sysconfig/stackdriver":
    ensure => file,
    owner => root,
    group => root,
    content => template("stackdriver/stackdriver.erb"),
    require => Package["stackdriver-agent"],
  }
}
