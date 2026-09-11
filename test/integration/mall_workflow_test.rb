require "test_helper"

class MallWorkflowTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "student@example.com", password: "password123", password_confirmation: "password123")
    @theme = Theme.create!(name_ru: "Крупные комплексы", name_en: "Large complexes")
    @mall = MallItem.create!(
      theme: @theme,
      name_ru: "ТРК Лето",
      name_en: "Leto Mall",
      description_ru: "Описание",
      description_en: "Description",
      address_ru: "Пулковское шоссе, 25",
      address_en: "25 Pulkovskoe Highway",
      image_url: "https://example.com/leto.jpg"
    )
  end

  test "work area requires login" do
    get "/ru/malls"

    assert_response :redirect
    assert_includes response.location, "/ru/login"
  end

  test "user can sign in and open work area" do
    post "/ru/login", params: { email: @user.email, password: "password123" }
    follow_redirect!

    assert_response :success
    assert_includes response.body, "Оцените ТЦ Санкт-Петербурга"
  end

  test "api returns first unevaluated mall and saves score" do
    post "/ru/login", params: { email: @user.email, password: "password123" }

    get "/api/v1/malls", params: { locale: "ru", theme_id: @theme.id }
    assert_response :success
    assert_equal @mall.id, response.parsed_body.dig("mall_item", "id")

    post "/api/v1/malls", params: {
      locale: "ru",
      mall_item_id: @mall.id,
      rating: 88,
      comment: "Хороший набор магазинов"
    }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

    assert_response :success
    assert_equal 88, @user.evaluations.last.rating
  end

  test "profile exports csv" do
    Evaluation.create!(user: @user, mall_item: @mall, rating: 92, comment: "Удобно")
    post "/ru/login", params: { email: @user.email, password: "password123" }

    get "/ru/profile/export"

    assert_response :success
    assert_includes response.body, "ТРК Лето"
  end
end
