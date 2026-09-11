class Theme < ApplicationRecord
  has_many :mall_items, dependent: :destroy

  validates :name_ru, presence: true, uniqueness: true
  validates :name_en, presence: true, uniqueness: true

  def localized_name
    I18n.locale == :en ? name_en : name_ru
  end
end
