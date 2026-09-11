class MallItem < ApplicationRecord
  belongs_to :theme
  has_many :evaluations, dependent: :destroy

  validates :name_ru, :name_en, :description_ru, :description_en,
    :address_ru, :address_en, :image_url, presence: true

  def localized_name
    I18n.locale == :en ? name_en : name_ru
  end

  def localized_description
    I18n.locale == :en ? description_en : description_ru
  end

  def localized_address
    I18n.locale == :en ? address_en : address_ru
  end

  def average_rating
    evaluations.average(:rating)&.to_f&.round(2)
  end
end
