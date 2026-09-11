require "test_helper"

class EvaluationTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "student@example.com", password: "password123", password_confirmation: "password123")
    @theme = Theme.create!(name_ru: "Центр города", name_en: "City center")
    @mall_item = MallItem.create!(
      theme: @theme,
      name_ru: "ТРЦ Галерея",
      name_en: "Galeria Mall",
      description_ru: "Описание",
      description_en: "Description",
      address_ru: "Лиговский проспект, 30А",
      address_en: "30A Ligovsky Avenue",
      image_url: "https://example.com/gallery.jpg"
    )
  end

  test "rating must be between 1 and 100" do
    assert Evaluation.new(user: @user, mall_item: @mall_item, rating: 1).valid?
    assert Evaluation.new(user: @user, mall_item: @mall_item, rating: 100).valid?
    assert_not Evaluation.new(user: @user, mall_item: @mall_item, rating: 0).valid?
    assert_not Evaluation.new(user: @user, mall_item: @mall_item, rating: 101).valid?
  end

  test "user can evaluate mall item only once" do
    Evaluation.create!(user: @user, mall_item: @mall_item, rating: 80)
    duplicate = Evaluation.new(user: @user, mall_item: @mall_item, rating: 90)

    assert_not duplicate.valid?
  end

  test "exports csv" do
    Evaluation.create!(user: @user, mall_item: @mall_item, rating: 77, comment: "Удобная навигация")

    csv = Evaluation.to_csv(@user.evaluations.includes(mall_item: :theme))

    assert_includes csv, "mall_name_ru"
    assert_includes csv, "ТРЦ Галерея"
    assert_includes csv, "77"
  end
end
