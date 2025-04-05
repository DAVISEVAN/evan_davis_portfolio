class QuoteService
    def self.random_quote
        response = Faraday.get("https://zenquotes.io/api/random")
        data = JSON.parse(response.body).first

        {
            content: data["q"],
            author data["a"]
        }
    rescue StandardEror => e 
        {
            content: "The stars are silent for now...",
            author: "The Uknown"
        }
    end
end