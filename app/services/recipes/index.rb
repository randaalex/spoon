module Recipes
  class Index < Base
    PER_PAGE = 3

    def initialize(page:)
      @page = page || 1
    end

    def call
      result = contentful.entries(content_type: RECIPE_CONTENT_TYPE, limit: PER_PAGE, skip: skip)

      {
        pages_total: result.total,
        pages_count: (result.total.to_f / PER_PAGE).ceil,
        data: result.items.map { |r| build_recipe(r) }
      }
    end

    private def skip
      (@page - 1) * PER_PAGE
    end
  end
end
