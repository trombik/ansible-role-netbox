extra_packages = []
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

describe file root_dir do
  it { should exist }
  it { should be_mode 755 }
  it { should be_directory }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
