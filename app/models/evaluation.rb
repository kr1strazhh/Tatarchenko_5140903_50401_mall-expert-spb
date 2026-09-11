require "csv"

class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :mall_item

  validates :rating, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 100
  }
  validates :comment, length: { maximum: 1_000 }, allow_blank: true
  validates :user_id, uniqueness: { scope: :mall_item_id }

  def self.to_csv(evaluations)
    CSV.generate(headers: true) do |csv|
      csv << ["mall_name_ru", "mall_name_en", "theme_ru", "theme_en", "rating", "comment", "created_at"]

      evaluations.each do |evaluation|
        mall = evaluation.mall_item
        theme = mall.theme
        csv << [
          mall.name_ru,
          mall.name_en,
          theme.name_ru,
          theme.name_en,
          evaluation.rating,
          evaluation.comment,
          evaluation.created_at
        ]
      end
    end
  end
end
