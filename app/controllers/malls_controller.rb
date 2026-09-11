class MallsController < ApplicationController
  before_action :authorize

  def index
    @themes = Theme.order(:id)
  end
end
