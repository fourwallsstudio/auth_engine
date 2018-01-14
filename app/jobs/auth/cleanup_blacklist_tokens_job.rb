class Auth::CleanupBlacklistTokensJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    Rails.logger.info "#{Time.current}: finished execution of the job: #{job.inspect}"
  end

  def perform
    puts 'Cleanup Blacklist Token Job'
    BlacklistToken.expired_tokens.each do |token|
      BlacklistToken.destroy token.first
    end
  end
end

puts "tken freeq #{Auth.cleanup_blacklist_tokens_freq}"

