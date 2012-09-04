server "vm36.weboak.nl", :app, :web, :db, :primary => true
set :branch, "master"
set :deploy_to, "/srv/Sites/yourapp/apps/yourapp"
set :listen_to, "www.example.nl"
set :unicorn_environment, "production"
set :rails_env, "production"

# Set RVM environment
set :rvm_ruby_string, '1.9.3@office_heroes'
set :rvm_type, :user  # Copy the exact line. I really mean :user here

set :mysql_host,  "localhost"
set :mysql_user,  "yourdbuser"
set :mysql_password, "secret-password"
set :mysql_database, "yourdb" 