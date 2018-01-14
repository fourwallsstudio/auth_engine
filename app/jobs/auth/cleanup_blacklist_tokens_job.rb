class Auth::CleanupBlacklistTokensJob < ApplicationJob
  queue_as :default

  def perform
    BlacklistToken.expired_tokens.each do |token|
      BlacklistToken.destroy token.first
    end
  end

end

Auth::CleanupBlacklistTokensJob.set(
  wait: Auth.cleanup_blacklist_tokens_freq
).perform_later

