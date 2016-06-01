# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'Spelack'
set :repo_url, 'git@github.com:MKenta/Spelack.git'
set :branch, 'test-1'
set :deploy_to, '/var/www/Spelack'
set :log_level, :debug
set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :npm_target_path, -> { release_path }
set :npm_flags, '--silent --no-progress'
set :nvm_type, :user
set :nvm_node, 'v5.10.1'
set :nvm_custom_path, '/usr/local/nvm'
set :npm_roles, :all
set :npm_env_variables, {}
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

namespace :gulp do
  task :deploy do
    on roles(:web) do
      within release_path do
        execute './node_modules/.bin/gulp', 'deploy'
      end
    end
  end
end
namespace :puma do
  task :cable_start do
    on roles(:web) do
      within current_path do
        execute :bundle, :exec, :puma, '-d -e production -p 28080 cable/config.ru'
      end
    end
  end
end
namespace :puma do
  task :cable_restart do
    on roles(:web) do
      within current_path do
        execute :bundle, :exec, :pumactl, '-e production --config cable/config.ru'
      end
    end
  end
end

namespace :deploy do
  desc 'Reset database'
  task :db_reset do
    on roles(:db) do |_host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:migrate:reset'
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
end
after 'npm:install', 'gulp:deploy'
after 'deploy:finished', 'puma:cable_start'
after 'deploy:publishing', 'deploy:restart'
