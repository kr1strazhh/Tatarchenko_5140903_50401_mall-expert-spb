module Api
  module V1
    class MallsApiController < ApplicationController
      before_action :authorize

      def index
        theme = Theme.find_by(id: params[:theme_id])
        return render json: { done: true, message: t("mall_expert.api.choose_theme") } unless theme

        scope = theme.mall_items.order(:id)
        evaluated_ids = current_user.evaluations.where(mall_item_id: scope.select(:id)).select(:mall_item_id)
        mall_item = scope.where.not(id: evaluated_ids).first

        if mall_item
          render json: mall_payload(mall_item)
        else
          render json: { done: true, message: t("mall_expert.api.theme_completed") }
        end
      end

      def create
        mall_item = MallItem.find(params[:mall_item_id])
        evaluation = current_user.evaluations.find_or_initialize_by(mall_item: mall_item)
        evaluation.rating = params[:rating]
        evaluation.comment = params[:comment]

        if evaluation.save
          render json: {
            status: "ok",
            message: t("mall_expert.api.saved"),
            average_rating: mall_item.average_rating,
            evaluations_count: mall_item.evaluations.count
          }
        else
          render json: { status: "error", errors: evaluation.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: "error", error: t("mall_expert.api.not_found") }, status: :not_found
      end

      private

      def mall_payload(mall_item)
        {
          done: false,
          mall_item: {
            id: mall_item.id,
            name: mall_item.localized_name,
            description: mall_item.localized_description,
            address: mall_item.localized_address,
            image_url: mall_item.image_url,
            theme: mall_item.theme.localized_name,
            average_rating: mall_item.average_rating,
            evaluations_count: mall_item.evaluations.count
          }
        }
      end
    end
  end
end
