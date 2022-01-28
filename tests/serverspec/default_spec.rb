require "spec_helper"
require "serverspec"

package = "netbox"
extra_packages = case os[:family]
                 when "freebsd"
                   ["security/py-netbox-secretstore"]
                 end
service = "netbox"
service_rq = "netbox_rq"
config_dir = case os[:family]
             when "freebsd"
               "/usr/local/netbox/netbox/netbox/netbox"
             end
config = "#{config_dir}/configuration.py"
local_requirements_txt = case os[:family]
                         when "freebsd"
                           "/usr/local/netbox/netbox/local_requirements.txt"
                         end
plugins = %w[
  netbox-qrcode
]
log_dir = "/var/log/netbox"
log_file = "#{log_dir}/netbox.log"
user    = case os[:family]
          when "openbsd"
            "_netbox"
          else
            "netbox"
          end
group   = user

ports   = [
  80,   # nginx
  5432, # postgrsql
  6379, # redis
  8001, # netbox
]

describe package(package) do
  it { should be_installed }
end

extra_packages.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 640 }
  its(:content) { should match Regexp.escape("Managed by ansible") }
end

describe file local_requirements_txt do
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 644 }
  its(:content) { should match Regexp.escape("Managed by ansible") }
  plugins.each do |p|
    its(:content) { should match Regexp.escape("#{p}") }
  end
end

describe file log_dir do
  it { should exist }
  it { should be_directory }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 755 }
end

describe file log_file do
  it { should exist }
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
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

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
