set :stage, :production
set :rails_env, 'production'
server '52.193.153.0', user: 'spelack-dev', roles: %w(app web db)
set :ssh_options, keys: '~/.ssh/aws_rsa'
