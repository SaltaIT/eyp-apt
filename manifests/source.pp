# apt::source { 'couchbase':
#   location => 'http://packages.couchbase.com/ubuntu',
#   release  => $::lsbdistcodename,
#   repos    => "${::lsbdistcodename}/main",
# }
#
# root@ubuntu16:~# cat /etc/apt/sources.list.d/couchbase.list
# deb http://packages.couchbase.com/ubuntu xenial xenial/main
# root@ubuntu16:~#
#
# puppet2sitepp @aptsources
#
define apt::source(
                    $ensure         = 'present',
                    $location       = undef,
                    $release        = undef,
                    $repos          = 'main',
                    $source_name    = $name,
                    $allow_unsigned = false,
                  ) {
  if versioncmp($::puppetversion, '4.0.0') >= 0
  {
    contain ::apt
  }
  else
  {
    include ::apt
  }

  file { "/etc/apt/sources.list.d/${source_name}.list":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/source.erb"),
    notify  => Exec['eyp-apt apt-get update'],
  }

}
