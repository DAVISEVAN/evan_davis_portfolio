class GuestbookEntry < ApplicationRecord
  prepend SignatureFormatter
  validates :name, presence: true
  validates :message, presence: true

  def formatted_signature
    "#{name} says: '#{message}'"
  end
end
