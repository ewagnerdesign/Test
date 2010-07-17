set :application, "Trovare"
set :repository,  "https://sphere-inc.com.ua:8081/svn/CTMS/develop"

set :scm, :subversion
set :deploy_via, :copy
set :copy_strategy, :export

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "root"
role :web, "173.203.92.205"                          # Your HTTP server, Apache/etc
role :app, "173.203.92.205"                          # This may be the same as your `Web` server
role :db,  "173.203.92.205", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
set :deploy_to, "/var/www/trovare/development/"
set :rake, '/var/lib/gems/1.8/bin/rake'
after "deploy:update_code", "db:symlink"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Default deploy"
  task :default do
    set :migrate_target, :latest
    update_code
    migrate
    symlink
    restart
  end
end

namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end
