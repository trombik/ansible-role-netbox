require "spec_helper"

describe service("sshd") do
  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening }
end

describe command "uname -a" do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/worker2/) }
end
