set :application, "kalenderwoche.christophbuente.de"

default_run_options[:pty] = true

set :user, "rails"

#ssh_options[:forward_agent] = true

set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to,           "/var/www/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, "git"
set :scm_passphrase, "niidmds!"
set :repository,  "git@github.com:christoph-buente/kalenderwoche.git"

role :app, "92.51.132.253"
role :web, "92.51.132.253"
role :db,  "92.51.132.253", :primary => true

namespace :deploy do
  
  [ :start, :stop, :restart ].each do |cmd|
    desc "#{cmd} Application"
    task cmd do
      run "touch #{current_path}/tmp/#{cmd}.txt"
    end
  end
  
  desc "Symlink all shared filed"
  task :after_symlink do
    run "ln -nfs #{shared_path}/cache #{release_path}/public/cache"
    run "sudo ln -nfs #{current_path}/config/apache.conf /etc/apache2/sites-available/www.nichklicken.de"
  end
  
end