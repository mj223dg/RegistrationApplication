class App < ActiveRecord::Base

  before_create :generate_api_key
  belongs_to :user
  validates :name, presence: true,
            length: { maximum: 100}

  private

  def generate_api_key
    begin
      self.apikey = SecureRandom.hex
    end while self.class.exists?(apikey: apikey)
  end
end
