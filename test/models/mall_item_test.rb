require "test_helper"

class MallItemTest < ActiveSupport::TestCase
  test "average rating is rounded" do
    user_one = User.create!(email: "one@example.com", password: "password123", password_confirmation: "password123")
    user_two = User.create!(email: "two@example.com", password: "password123", password_confirmation: "password123")
    theme = Theme.create!(name_ru: "Семейный досуг", name_en: "Family leisure")
    mall = MallItem.create!(
      theme: theme,
      name_ru: "ТРЦ Охта Молл",
      name_en: "Okhta Mall",
      description_ru: "Описание",
      description_en: "Description",
      address_ru: "Брантовская дорога, 3",
      address_en: "3 Brantovskaya Road",
      image_url: "https://example.com/okhta.jpg"
    )

    Evaluation.create!(user: user_one, mall_item: mall, rating: 70)
    Evaluation.create!(user: user_two, mall_item: mall, rating: 91)

    assert_equal 80.5, mall.average_rating
  end
end
