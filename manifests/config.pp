class stackdriver::config{
  # OS Family specific configuration
  class { $::stackdriver::cclass:
    apikey => $::stackdriver::apikey,
  }
  contain $::stackdriver::cclass
}
