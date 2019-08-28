# apt

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What apt affects](#what-apt-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with apt](#beginning-with-apt)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

apt management

## Module Description

* ppa installation using **add-apt-repository** (**software-properties-common** is mandatory)
* pin packages using **preferences.d**
* keys using **apt-key adv**
* repos using **sources.list.d**

## Setup

### What apt affects

* Creates files under /etc/apt but not modifies already created files
* Manages package **software-properties-common**

### Setup Requirements

This module requires pluginsync enabled

### Beginning with apt

```puppet
include ::apt
```

Including **::apt** creates a resource to perform an apt-get update only if needed

## Usage

### add repo

```puppet
apt::source { 'couchbase':
  location => 'http://packages.couchbase.com/ubuntu',
  release  => $::lsbdistcodename,
  repos    => "${::lsbdistcodename}/main",
}
```

### pin repo by originator

```puppet
apt::pin { 'dontblamenrpe':
  originator => 'LP-PPA-dontblamenrpe',
  priority   => '700',
  require    => Apt::Ppa['ppa:dontblamenrpe/ppa']
}
```

### manage keys

```puppet
apt::key { 'couchbase':
  key        => '136CD3BA884E3CB0E44E7A5BE905C770CD406E62',
  key_source => 'http://packages.couchbase.com/ubuntu/couchbase.key',
}
```

Show installed keys:

```
# apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep -i grafa
uid:-::::1485266258::54754BA7A63B8C9E73D8BFCB81140F31DD4C2D55::Grafana <info@grafana.com>:
```

### add PPA

```puppet
apt::ppa { 'ppa:dontblamenrpe/ppa':
  ensure => 'present',
}
```

## Reference

TODO

## Limitations

This module is tested on Ubuntu 16

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
