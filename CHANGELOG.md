# CHANGELOG

## 0.1.12

* added support for **Ubuntu 20.04**

## 0.1.11

* added support for Debian 7, Debian 8, Debian 9 and Debian 10

## 0.1.10

* bugfix **apt::unattendedupgrades**

## 0.1.9

* added several options to **apt::unattendedupgrades**

## 0.1.8

* added **apt::unattendedupgrades**

## 0.1.7

* added patching related tasks:
  - listpackages
  - update
  - checkupdate

## 0.1.6

* added support for Ubuntu 18.04

## 0.1.5

* bugfix: ensure apt-get update is updated in **apt::ppa** and **apt::source**

## 0.1.4

* added cronjob to run apt-get update

## 0.1.3

* added support for https for **apt::key**

## 0.1.2

* added **apt::source** and **apt::key**
* added acceptance testing

## 0.1.1

* bugfix: apt-get update
* added package **software-properties-common** under management

## 0.1.0

* initial release
