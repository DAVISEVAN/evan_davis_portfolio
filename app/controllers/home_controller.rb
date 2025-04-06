class HomeController < ApplicationController
  def index
    @quote = Rails.cache.read("quotes") || [
      { content: "Default quote if cache is empty", authoer: "Unknown" }
    ]
  end
end
