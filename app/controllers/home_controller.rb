class HomeController < ApplicationController
  def index
    @quote = Rails.cache.read("quotes") || []
  end
end
