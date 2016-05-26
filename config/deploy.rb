# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'Spelack'
set :repo_url, 'git@github.com:MKenta/Spelack.git'
set :branch, 'deploy_test'
set :deploy_to, '/var/www/Spelack'
set :log_level, :debug
set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'

set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets)
set :rbenv_ruby, '2.2.3'

namespace :deploy do
  desc 'Create database'
  task :db_create do
    on roles(:db) do |_host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end
end
after 'deploy:publishing', 'deploy:restart'
