require_relative "spec_helper"

load "#{File.realpath(__dir__)}/common_spec.rb"

service = "netbox"
service_rq = case os[:family]
             when "ubuntu", "fedora"
               "netbox-rq"
             else
               "netbox_rq"
             end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/netbox") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
    it { should be_mode 644 }
    its(:content) { should match(/Managed by ansible/) }
  end

  describe file("/etc/rc.conf.d/netbox_rq") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
    it { should be_mode 644 }
    its(:content) { should match(/Managed by ansible/) }
  end

  describe file("/usr/local/etc/rc.d/netbox") do
    it { should exist }
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
  end

  describe file("/usr/local/etc/rc.d/netbox_rq") do
    it { should exist }
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by "root" }
    it { should be_grouped_into "wheel" }
  end
end

describe service(service_rq) do
  it { should be_running }
  it { should be_enabled }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end
