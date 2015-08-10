class stackdriver::install{
  # OS Family specific installation
  class { $::stackdriver::iclass:
    ensure => $stackdriver::ensure,
  }
  contain $::stackdriver::iclass
}
