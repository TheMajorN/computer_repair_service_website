class Ticket < ApplicationRecord
  before_create :generate_order_number

  validates :status, presence: true

  private

  def split_email_or_phone(email_or_phone)
    if email_or_phone.present?
      if email_or_phone.include?('@')
        self.email = email_or_phone
      else
        self.phone = email_or_phone
      end
    end
  end

  def generate_order_number
    length = rand(10..15) # Adjust length as needed
    characters = ('A'..'Z').to_a + (0..9).to_a
    self.order_number = Array.new(length) { characters.sample }.join
  end
end