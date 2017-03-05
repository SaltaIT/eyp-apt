require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apt class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'apt': }

      apt::pin { 'dontblamenrpe':
      	originator => 'LP-PPA-dontblamenrpe',
      	priority   => '700',
      }

      apt::ppa { 'ppa:dontblamenrpe/ppa':
      	ensure => 'present',
      }

      apt::source { 'couchbase':
        location => 'http://packages.couchbase.com/ubuntu',
        release  => $::lsbdistcodename,
        repos    => "${::lsbdistcodename}/main",
      }

      apt::key { 'couchbase':
        ensure => 'absent',
        key        => '136CD3BA884E3CB0E44E7A5BE905C770CD406E62',
        key_source => 'http://packages.couchbase.com/ubuntu/couchbase.key',
      }


      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

  end
end
