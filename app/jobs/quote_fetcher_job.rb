class QuoteFetcherJob
    include Sidekiq::Job 

    def perform
        response = Faraday.get("https://zenquotes.io/api/quotes")
        quotes = JSON.parse(response.body).map do |quote|
            {
                content: quote["q"],
                author: quote["a"]
            }
        end

        Rails.cache.write("quotes", quotes, expires_in: 1.hour)
    rescue => e 
        Rails.logger.error("QuoteFetcherJob failed: #{e.message}")
    end
end