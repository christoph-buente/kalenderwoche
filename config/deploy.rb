set :application, "whatweekisit"

default_run_options[:pty] = true

set :user, "rails"
set :ssh_options, :keys => [ File.expand_path("~/.ssh/id_rsa") ]
ssh_options[:forward_agent] = true
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to,           "/var/www/rails/www.#{application}.net"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, "git"
set :scm_passphrase, "niidmds!"
set :repository,  "git@github.com:christoph-buente/kalenderwoche.git"

# role :app, "92.51.132.253"
# role :web, "92.51.132.253"
# role :db,  "92.51.132.253", :primary => true

role :app, "83.169.47.164"
role :web, "83.169.47.164"
role :db,  "83.169.47.164", :primary => true

after 'deploy:update_code', 'deploy:symlinking'

namespace :deploy do
  
  [ :start, :stop, :restart ].each do |cmd|
    desc "#{cmd} Application"
    task cmd do
      run "touch #{current_path}/tmp/#{cmd}.txt"
    end
  end
  
  desc "Symlink all shared filed"
  task :symlinking do
    run "ln -nfs #{shared_path}/cache #{release_path}/public/cache"
    run "sudo ln -nfs #{current_path}/config/apache.conf /etc/apache2/sites-available/www.#{application}.net"
  end
  
end

namespace :passenger do
  
  desc "passenger memory stats"
  task :memory, :roles => :app do
    run "sudo /home/rails/.rvm/gems/ree-1.8.7-2010.02/bin/passenger-memory-stats" do |channel, stream, data|
      puts data
    end
  end

  desc "passenger general info"
  task :status, :roles => :app  do
    run "sudo /home/rails/.rvm/gems/ree-1.8.7-2010.02/bin/passenger-status"
  end
end