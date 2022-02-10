require "spec_helper"
require "serverspec"

extra_packages = []
service = "netbox"
service_rq = case os[:family]
             when "ubuntu", "fedora"
               "netbox-rq"
             else
               "netbox_rq"
             end
root_dir = case os[:family]
           when "ubuntu", "devuan", "fedora"
             "/opt/netbox"
           when "openbsd"
             "/var/www/htdocs/netbox"
           when "freebsd"
             "/usr/local/netbox"
           else
             raise format("unknown os[:family]: %s", os[:family])
           end
config_dir = "#{root_dir}/netbox/netbox/netbox"
config = "#{config_dir}/configuration.py"
gunicorn_config = "#{config_dir}/gunicorn.py"
local_requirements_txt = case os[:family]
                         when "ubuntu", "devuan", "fedora"
                           "/opt/netbox/netbox/local_requirements.txt"
                         when "openbsd"
                           "/var/www/htdocs/netbox/netbox/local_requirements.txt"
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

describe file gunicorn_config do
  it { should exist }
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 644 }
  its(:content) { should match Regexp.escape("Managed by ansible") }
end

describe file local_requirements_txt do
  it { should be_file }
  it { should be_owned_by user }
  it { should be_grouped_into group }
  it { should be_mode 644 }
  its(:content) { should match Regexp.escape("Managed by ansible") }
  plugins.each do |p|
    its(:content) { should match Regexp.escape(p.to_s) }
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
when "devuan"
  describe package "supervisor" do
    it { should be_installed }
  end

  describe service "supervisor" do
    it { should be_running }
  end

  describe file "/etc/supervisor/conf.d/netbox.conf" do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
  end
end

case os[:family]
when "devuan"
  describe service(service_rq) do
    it { should be_running.under("supervisor") }
  end

  describe service(service) do
    it { should be_running.under("supervisor") }
  end
else
  describe service(service_rq) do
    it { should be_running }
    it { should be_enabled }
  end

  describe service(service) do
    it { should be_running }
    it { should be_enabled }
  end
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
