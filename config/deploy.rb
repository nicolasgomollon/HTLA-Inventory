require 'bundler/capistrano'

default_run_options[:pty] = true

set :gateway, "ww2.hthla.org"

set :application, "HTLA Inventory"
set :repository,  "git://github.com/nicolasgomollon/HTLA-Inventory.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/inventory"
set :user, "jmoore"
server "10.1.2.24", :app, :web, :db, :primary => true

after 'deploy:create_symlink', 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Start the Thin processes"
  task :start do
    sudo  <<-CMD
      /etc/init.d/thin start
    CMD
  end

  desc "Stop the Thin processes"
  task :stop do
    sudo  <<-CMD
      /etc/init.d/thin stop
    CMD
  end

  desc "Start the Thin processes"
  task :restart do
    sudo <<-CMD
      /etc/init.d/thin restart
    CMD
  end
end


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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
