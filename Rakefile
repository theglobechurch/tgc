# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'rubocop/rake_task'

Rails.application.load_tasks

desc 'Rubocop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb',
                   'app/**/*.rb',
                   'config/**/*.rb',
                   'test/**/*.rb']
  task.fail_on_error = true
end


task :test => ['bundle_audit:run', 'rubocop', 'brakeman:check']