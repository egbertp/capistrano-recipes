server "ruby.weboak.nl", :app, :web, :db, :primary => true
#set :branch, "staging-new"
set :branch, "master"
set :deploy_to, "/srv/Sites/yourapp/apps/yourapp"
set :listen_to, "staging.officeheroes.nl"
set :unicorn_environment, "staging"
set :rails_env, "staging"

# Set RVM environment
set :rvm_ruby_string, '1.9.3@yourapp'
set :rvm_type, :user  # Copy the exact line. I really mean :user here

set :mysql_host,  "localhost"
set :mysql_user,  "yourdbuser"
set :mysql_password, "secret_password"
set :mysql_database, "yourdb" 