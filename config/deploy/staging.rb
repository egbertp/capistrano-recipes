server "ruby.weboak.nl", :app, :web, :db, :primary => true
set :deploy_to, "/srv/Sites/customer_backend/app"
set :listen_to, "staging.backend.weboak.nl"
set :unicorn_environment, "staging"
set :rails_env, "production"