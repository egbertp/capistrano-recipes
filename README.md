# Capistrano recipes
***

# Introduction

The contents of this capistrano-recipes-ruby application can be used to quickly deploy a Rails app using Capistrano. The configuration is done for a multistage environment where you have a staging and a production server.

Note: This configuration works for me. It is still work in progress. I plan to add other recipes for PHP later. I'll put those in a different branch. 


# Install Capistrano

Add the `capistrano` gem and the `capistrano-ext` gem to your gemfile. 

    # Deploy with Capistrano
    gem 'capistrano'
    gem 'capistrano-ext'
    gem 'rvm-capistrano'

Run the bundle command

    $ bundle install

# Prepare your Project for Capistrano

Navigate to your application’s root directory in Terminal and run the following command:

    $ capify .

This command creates a special file called CAPFILE in your project, and adds a template deployment recipe at CONFIG/DEPLOY.RB in your Rails project. The Capfile helps Capistrano load your recipes and libraries properly, but you don’t need to edit it for now.

Instead, open the DEPLOY.RB file in your favorite text editor. This file is where all the magic happens! You can start by deleting everything in the template file, as this guide will help you fill it with the correct code for a successful deployment recipe.

# Prepare servers

First, create user account on staging and development server

    $ adduser --home /srv/Sites/your_project_name --disabled-password --disabled-login your_project_name

Then transfer your ~/.ssh/id_rsa.pub file to the ~/.ssh/authorized_keys file on the server. 

    $ scp ~/.ssh/id_rsa.pub root@server.domain.nl:/srv/Sites/your_project_name/.ssh/authorized_keys

Connect to the server without using a password

    $ ssh -l project_name server.domain.nl

If you can connect to the server without the need to enter a password, you may continue to intialize your capistrano deployment on the server

Install the Ruby environment on your server 

    $ curl -L get.rvm.io | bash -s stable

Load RVM and install Ruby 1.9.3

    $ source ~/.rvm/scripts/rvm
    $ rvm install 1.9.3
    $ rvm --default use 1.9.3
    $ rvm gemset create your_project_name
    $ rvm gemset use your_project_name

# Set the project specific variables

Change the variables in the file config/deploy/production.rb: 

    server "vm36.weboak.nl", :app, :web, :db, :primary => true
    set :deploy_to, "/srv/Sites/customer_backend/app"
    set :listen_to, "backend.weboak.nl"
    set :unicorn_environment, "production"
    set :rails_env, "production"

Change the variables in the file config/deploy/staging.rb: 

    server "ruby.weboak.nl", :app, :web, :db, :primary => true
    set :deploy_to, "/srv/Sites/customer_backend/app"
    set :listen_to, "staging.backend.weboak.nl"
    set :unicorn_environment, "staging"
    set :rails_env, "production"

Make some changes in the top part of config/deploy.rb

    set :stages, ["staging", "production"]
    set :default_stage, "staging"
    require 'capistrano/ext/multistage'

    set :application, "customer_backend"
    set :user, "customer_backend"
    set :use_sudo, false

    set :scm, :git
    set :repository,  "git@github.com:egbertp/project_name.git"

# Load RVM's capistrano plugin.
require "rvm/capistrano"                  

# Set RVM environment
set :rvm_ruby_string, '1.9.3@customer_backend'
set :rvm_type, :user  # Copy the exact line. I really mean :user here

# Deploy using Capistrano

Now everything is set for deployment to the staging server

    $ cap deploy:setup
    $ cap deploy:cold
    $ cap deploy 

# License

Free for personal or commercial use GPL 3. 
