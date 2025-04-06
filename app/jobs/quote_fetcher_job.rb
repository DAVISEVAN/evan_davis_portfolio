class QuoteFetcherJob
    include Sidekiq::Job
  
    def perform
      response = Faraday.get("https://zenquotes.io/api/quotes")
  
      if response.success?
        quotes = JSON.parse(response.body).map do |quote|
          {
            content: quote["q"],
            author: quote["a"]
          }
        end
  
        Rails.cache.write("quotes", quotes, expires_in: 1.hour)
        Rails.logger.info "✅ Quotes written to cache: #{quotes.first[:content]}"
      else
        Rails.logger.warn "❌ Quote fetch failed: #{response.status}"
      end
    end
  end
  