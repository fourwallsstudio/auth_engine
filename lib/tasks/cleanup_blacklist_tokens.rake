namespace 'auth' do
  desc "start cleanup blacklist tokens job"
  task :cleanup_blacklist_tokens => :environment do
    puts "start cleanup blacklist tokens job"
    Auth::CleanupBlacklistTokensJob.perform_now
  end
end

