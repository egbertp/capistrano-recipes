server "vm36.weboak.nl", :app, :web, :db, :primary => true
set :deploy_to, "/srv/Sites/customer_backend/app"
set :listen_to, "backend.weboak.nl"
set :unicorn_environment, "production"
set :rails_env, "production"