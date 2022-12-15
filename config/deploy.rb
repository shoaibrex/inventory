# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "inventorious"
set :repo_url, "https://github.com/shoaibrex/inventory.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/ubuntu/inventory'
# Default value for :format is :airbrussh.
# set :format, :airbrussh
append :rbenv_map_bins, 'puma', 'pumactl'
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://home/ubuntu/inventory/shared/tmp/sockets/puma.sock"    #accept array for multi-bind
# set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 2
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true
# set :puma_preload_app, false
# Default value for :pty is false
# set :pty, true
set :pty, true
#set :ssh_options, { forward_agent: true, user: "ubuntu", keys: File.expand_path('/Users/apple/www/mtc-stock-app.pem') }

# set :ssh_options, { 
#   forward_agent: true,
#   auth_methods: %w[publickey],
#   keys: %w[/Users/apple/www/mtc-stock-app.pem]
# }


# namespace :deploy do
#   desc "Run seed"
#   task :seed do
#     on roles(:all) do
#       within current_path do
#         execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
#       end
#     end
#   end
 
#   after :migrating, :seed
# end
namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# set :default_env, {
#     path: '/usr/local/rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH',
#     rbenv_root: '/usr/local/rbenv'
# }
# set :rbenv_roles, :all
# set :rbenv_ruby, '2.2.2'
# set :rbenv_ruby_dir, '/usr/local/rbenv/versions/2.2.2'
# set :rbenv_custom_path, '/usr/local/rbenv'
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rbenv_type, 'ubuntu' # :user or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, '/usr/bin/rbenv exec'