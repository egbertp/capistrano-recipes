set :stages, ["staging", "production"]
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'sidekiq/capistrano'

set :application, "customer_backend"
set :user, "customer_backend"
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:egbertp/project_name.git"

# Load RVM's capistrano plugin.
require "rvm/capistrano"                  

require "bundler/capistrano"

load "config/deploy/recipes/base"
load "config/deploy/recipes/nginx"
load "config/deploy/recipes/unicorn"
# Choose either MySQL or PostgreSQL
load "config/deploy/recipes/mysql"
load "config/deploy/recipes/postgresql"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end