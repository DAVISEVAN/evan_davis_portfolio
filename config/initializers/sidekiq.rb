require 'sidekiq'
require 'sidekiq-cron'

# Redis configuration for both client and server
Sidekiq.configure_server do |config|
  config.redis = { 
    url: ENV.fetch("REDIS_URL"),
     ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
    }

  # Cron Jobs
  Sidekiq::Cron::Job.create(
    name: 'Fetch quotes every 10 minutes',
    cron: '*/10 * * * *',
    class: 'QuoteFetcherJob'
  )

  Sidekiq::Cron::Job.load_from_hash!(
    'guestbook_cleanup' => {
      'class' => 'GuestbookCleanupJob',
      'cron' => '0 0 * * *', # Every day at midnight
      'description' => 'Deletes duplicate guestbook entries '
    }
  )
end

Sidekiq.configure_client do |config|
  config.redis = { 
    url: ENV.fetch("REDIS_URL"), 
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Rails.application.config.after_initialize do 
  QuoteFetcherJob.perform_async
end