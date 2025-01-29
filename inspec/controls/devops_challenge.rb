control 'nginx_installed' do
    impact 1.0
    title 'Verify nginx is installed and running'
    describe package('nginx') do
      it { should be_installed }
    end
    describe service('nginx') do
      it { should be_running }
      it { should be_enabled }
    end
  end
  
  control 'nginx_welcome_page' do
    impact 1.0
    title 'Validate nginx default page message'
    describe file('/var/www/html/index.nginx-debian.html') do
      its('content') { should match /Welcome to the DevOps Challenge/ }
    end
  end
  
  control 'ssh_configuration' do
    impact 1.0
    title 'Ensure SSH root login is disabled and port is 22'
    describe sshd_config do
      its('PermitRootLogin') { should eq 'no' }
      its('Port') { should eq '22' }
    end
  end
  
  control 'devops_user' do
    impact 1.0
    title 'Ensure devops user exists and has sudo privileges'
    describe user('devops') do
      it { should exist }
      its('groups') { should include 'sudo' }
    end
  end