class User < ApplicationRecord
  has_secure_password

  has_many :evaluations, dependent: :destroy
  has_many :evaluated_mall_items, through: :evaluations, source: :mall_item

  before_validation :normalize_email

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
