class ProfilesController < ApplicationController
  before_action :authorize

  def show
    @evaluations = current_user.evaluations.includes(mall_item: :theme).order(created_at: :desc)
    @average_rating = @evaluations.average(:rating)&.to_f&.round(2)
    @by_theme = current_user.evaluations.joins(mall_item: :theme).group("themes.id", "themes.name_ru", "themes.name_en").count
    @top_evaluation = @evaluations.max_by(&:rating)
  end

  def export
    evaluations = current_user.evaluations.includes(mall_item: :theme).order(created_at: :desc)

    send_data Evaluation.to_csv(evaluations),
      filename: "my_evaluations.csv",
      type: "text/csv; charset=utf-8"
  end
end
