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

      apt::ppa { 'ppa:phalcon/stable':
      	ensure => 'present',
      }

      apt::source { 'couchbase':
        location => 'http://packages.couchbase.com/ubuntu',
        release  => $::lsbdistcodename,
        repos    => "${::lsbdistcodename}/main",
      }

      apt::key { 'couchbase':
        key        => '136CD3BA884E3CB0E44E7A5BE905C770CD406E62',
        key_source => 'http://packages.couchbase.com/ubuntu/couchbase.key',
      }


      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    # PIN
    describe file("/etc/apt/preferences.d/dontblamenrpe") do
      it { should be_file }
      its(:content) { should include('# puppet managed file') }
      its(:content) { should include('Package: *') }
      its(:content) { should include('Pin: release o=LP-PPA-dontblamenrpe') }
      its(:content) { should include('Pin-Priority: 700') }
    end

    # PPA
    #
    it "check apt::ppa" do
      expect(shell("apt-cache policy | grep phalcon").exit_code).to be_zero
    end

    # source
    describe file("/etc/apt/sources.list.d/couchbase.list") do
      it { should be_file }
      its(:content) { should include('deb http://packages.couchbase.com/ubuntu') }
    end

    # key
    it "check apt::key" do
      expect(shell("apt-key adv --list-keys --with-colons --fingerprint --fixed-list-mode | grep 136CD3BA884E3CB0E44E7A5BE905C770CD406E62").exit_code).to be_zero
    end

  end
end
