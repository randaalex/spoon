module Recipes
  class Show < Base
    def initialize(id:)
      @recipe_id = id
    end

    def call
      raw_recipe = Rails.cache.fetch("recipe-#{@recipe_id}", expires_in: 5.minutes) do
        contentful.entry(@recipe_id, content_type: RECIPE_CONTENT_TYPE )
      end

      raise NotFoundError if raw_recipe.blank?

      build_recipe(raw_recipe)
    end
  end
end
