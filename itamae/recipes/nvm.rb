NVM_DIR = '/usr/local/nvm'.freeze
NVM_SCRIPT = '/etc/profile.d/nvm.sh'.freeze

git NVM_DIR do
  repository 'git://github.com/creationix/nvm.git'
end

remote_file NVM_SCRIPT do
  source '../remote_files/nvm.sh'
end

execute "set owner and mode for #{NVM_SCRIPT} " do
  command "chown root: #{NVM_SCRIPT}; chmod 644 #{NVM_SCRIPT}"
  user 'root'
end

execute "install node v5.10.1" do
  command "source #{NVM_SCRIPT}; nvm install 5.10.1"
end

execute "set global node v5.10.1" do
  command "source #{NVM_SCRIPT}; nvm alias default 5.10.1"
  not_if "source #{NVM_SCRIPT}; nvm alias default | grep v5.10.1"
end
