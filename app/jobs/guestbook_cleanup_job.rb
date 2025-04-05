class GuestbookCleanupJob
    include Sidekiq::Job 

    def perform
        seen = {}

        GuestbookMessage.order(:created_at).find_each do |message|
            key = [message.user_id, message.content.strip.downcase]

            if seen[key]
                message.destroy
            else
                seen[key] = true
            end
        end
    end
end