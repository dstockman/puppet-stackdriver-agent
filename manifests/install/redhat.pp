# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::install::redhat
#
# Installs Stackdriver Agent for RedHat derivatives
#
# === Parameters
#
# Use Hiera for overriding any parameter defaults
#
# ---
#
# [*pkg*]
# - Default - stackdriver-agent
# - RPM package name
#
# [*ensure*]
# - Default - present
# - {Puppet Package Ensure Attribute}[http://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure]
#
# [*repo*]
# - Default: (hash)
#  {
#    'baseurl'   => 'http://repo.stackdriver.com/repo/el6/$basearch/',
#    'gpgkey'    => 'https://www.stackdriver.com/RPM-GPG-KEY-stackdriver',
#    'descr'     => 'stackdriver',
#    'enabled'   => 1,
#    'gpgcheck'  => 1,
#  }
# - Yum Repository containing stackdriver RPM package(s)
#
class stackdriver::install::redhat(

  $pkg    = 'stackdriver-agent',
  $ensure = 'present',

  $repo = {
    'baseurl'   => 'http://repo.stackdriver.com/repo/el6/$basearch/',
    'gpgkey'    => 'https://www.stackdriver.com/RPM-GPG-KEY-stackdriver',
    'descr'     => 'stackdriver',
    'enabled'   => 1,
    'gpgcheck'  => 1,
  },

) inherits stackdriver {

  validate_string ( $pkg    )
  validate_string ( $ensure )
  validate_hash   ( $repo   )

  # Setup repo
  ensure_resource('yumrepo', 'stackdriver-agent', $repo)

  # Install package
  ensure_resource('package', $pkg, {
    'ensure'  => $ensure,
    'require' => Yumrepo['stackdriver-agent']
  })

}

