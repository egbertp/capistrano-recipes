set_default(:mysql_host) { "localhost" }
set_default(:mysql_root_user) { "root" }
set_default(:mysql_root_password) { Capistrano::CLI.password_prompt "MySQL Password administrator user: '#{mysql_root_user}': " }
set_default(:mysql_user) { "office_heroes" }
set_default(:mysql_password) { Capistrano::CLI.password_prompt "MySQL Password for '#{mysql_user}': " }
set_default(:mysql_database) { "office_heroes_production" }

namespace :mysql do
   desc "Create MySQL database and user for this environment using prompted values"
    task :create_database, roles: :db, :only => { :primary => true } do

      sql = <<-SQL
      CREATE DATABASE #{mysql_database};
      GRANT ALL PRIVILEGES ON #{mysql_database}.* TO #{mysql_user}@localhost IDENTIFIED BY '#{mysql_password}';
      SQL

      run "mysql --user=#{mysql_root_user} -p --execute=\"#{sql}\"" do |channel, stream, data|
        if data =~ /^Enter password:/
          pass = Capistrano::CLI.password_prompt "Enter database password for '#{mysql_root_user}':"
          channel.send_data "#{pass}\n" 
        end
      end
  end
  after "deploy:setup", "mysql:create_database"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "mysql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "mysql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "mysql:symlink"
end





