require 'bundler/audit/cli'

namespace :bundle_audit do
  desc 'Update bundle-audit database'
  task :update do
    dir = ::Bundler::Audit::Database::USER_PATH
    fetch_head = File.join(dir, '.git/FETCH_HEAD')
    exists = File.directory?(dir) && File.exist?(fetch_head)
    # rubocop:disable Rails/Date
    # Would use the recommended Time.zone.today here, but the timezone hasn't
    # been set this early in Rails starting
    old = exists && (File.stat(fetch_head).mtime.to_date < Date.today)
    # rubocop:enable Rails/Date
    Bundler::Audit::CLI.new.update if !exists || old
  end

  desc 'Check gems for vulns using bundle-audit'
  task :check do
    Bundler::Audit::CLI.new.check
  end

  desc 'Update vulns database and check gems using bundle-audit'
  task :run do
    Rake::Task['bundle_audit:update'].invoke
    Rake::Task['bundle_audit:check'].invoke
  end
end

task :bundle_audit do
  Rake::Task['bundle_audit:run'].invoke
end
