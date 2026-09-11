module ApplicationHelper
  def mall_image_or_fallback(mall_item)
    fallback = image_path("food_fallback.svg")
    return fallback unless mall_item&.image_url.present?

    mall_item.image_url
  rescue StandardError
    fallback
  end
end
