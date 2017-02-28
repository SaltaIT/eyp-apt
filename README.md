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

* ppa installation
* pin packages

## Setup

### What apt affects

This module creates files under /etc/apt but not modifies already created files

### Setup Requirements

This module requires pluginsync enabled

### Beginning with apt

```puppet
apt::ppa { 'ppa:dontblamenrpe/ppa':
  ensure => 'present',
}

apt::pin { 'dontblamenrpe':
  originator => 'LP-PPA-dontblamenrpe',
  priority   => '700',
  require    => Apt::Ppa['ppa:dontblamenrpe/ppa']
}
```

## Usage

TODO

## Reference

TODO

## Limitations

This module is tested on Ubuntu 16

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

* apt::source
* apt::key

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
