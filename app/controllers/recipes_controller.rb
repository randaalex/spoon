class RecipesController < ApplicationController
  def index
    @page = (params[:page] || 1).to_i

    result = Recipes::Index.new(page: @page).call

    @recipes = result[:data]
    @pages_total = result[:pages_total]
    @pages_count = result[:pages_count]
  end

  def show
    @recipe ||= Recipes::Show.new(id: params[:id]).call
  end
end

