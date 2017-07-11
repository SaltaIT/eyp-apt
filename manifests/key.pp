# apt::key { 'couchbase':
#   key        => '136CD3BA884E3CB0E44E7A5BE905C770CD406E62',
#   key_source => 'http://packages.couchbase.com/ubuntu/couchbase.key',
# }
#
# puppet2sitepp @aptkeys
#
define apt::key (
                  $key,
                  $key_source,
                  $ensure = 'present',
                  $key_name = $name,
                ) {
  include ::apt

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  case $ensure
  {
    'present':
    {
      # apt-key adv --fetch-keys http://packages.couchbase.com/ubuntu/couchbase.key
      if($key_source=~ /^https/)
      {
        exec { 'which wget eyp-apt key':
          command => 'which wget',
          unless  => 'which wget',
        }

        exec { "key import ${key_name}":
          command => "wget -O - ${key_source} | apt-key add -",
          unless  => "bash -c 'apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep ${key}'",
          require => Exec['which wget eyp-apt key'],
        }
      }
      else
      {
        exec { "key import ${key_name}":
          command => "apt-key adv --fetch-keys ${key_source}",
          unless  => "bash -c 'apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep ${key}'",
        }
      }
    }
    'absent':
    {
      exec { "key del ${key_name}":
        command => "apt-key del ${key}",
        onlyif  => "bash -c 'apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep ${key}'",
      }
    }
    default:
    {
      fail('unsupported mode')
    }
  }
}
