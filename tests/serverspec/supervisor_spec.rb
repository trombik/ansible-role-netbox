require_relative "spec_helper"

load "#{File.realpath(__dir__)}/common_spec.rb"

supervisor_service_netbox = "netbox"
supervisor_service_netbox_rq = "netbox-rq"

supervisor_package = case os[:family]
                     when "devuan"
                       "supervisor"
                     end
supervisor_conf_file = case os[:family]
                       when "freebsd"
                         "/usr/local/etc/supervisor/conf.d/netbox.conf"
                       when "devuan"
                         "/etc/supervisor/conf.d/netbox.conf"
                       end
supervisor_service = "supervisor"

describe package supervisor_package do
  it { should be_installed }
end

describe service supervisor_service do
  it { should be_running }
end

describe file supervisor_conf_file do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by "root" }
  it { should be_grouped_into "root" }
end

describe service(supervisor_service_netbox_rq) do
  it { should be_running.under("supervisor") }
end

describe service(supervisor_service_netbox) do
  it { should be_running.under("supervisor") }
end
