set :stage, :staging
set :rails_env, 'staging'
set :node_env, 'production'
server '52.196.227.190', user: 'spelack-dev', roles: %w(app web db)
set :ssh_options, keys: '~/.ssh/aws_rsa'
