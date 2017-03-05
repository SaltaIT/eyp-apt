# apt::key { 'couchbase':
#   key        => '136CD3BA884E3CB0E44E7A5BE905C770CD406E62',
#   key_source => 'http://packages.couchbase.com/ubuntu/couchbase.key',
# }
define apt::key (
                  $key,
                  $key_source,
                  $ensure = 'present',
                  $key_name = $name,
                ) {
  include ::apt

  case $ensure
  {
    'present':
    {
      # apt-key adv --fetch-keys http://packages.couchbase.com/ubuntu/couchbase.key
      exec { "key import ${key_name}":
        command => "apt-key adv --fetch-keys ${key_source}",
        unless  => "bash -c 'apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep ${key}'",
        path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      }
    }
    'absent':
    {
      exec { "key import ${key_name}":
        command => "apt-key del ${key}",
        onlyif  => "bash -c 'apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep ${key}'",
        path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      }
    }
    default:
    {
      fail('unsupported mode')
    }
  }
}
