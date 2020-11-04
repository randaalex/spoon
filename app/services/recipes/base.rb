module Recipes
  class Base
    private def contentful
      @contentful ||= Contentful::Client.new(
        space: Settings.contentful.space,
        access_token: Settings.contentful.access_token,
        raise_for_empty_fields: false,
        dynamic_entries: :auto,
      )
    end

    private def build_recipe(raw_recipe)
      Recipe.new(
        id: raw_recipe.id,
        title: raw_recipe.title,
        image_url: raw_recipe.photo.url,
        description: raw_recipe.description,
        chef: build_chef(raw_recipe&.chef),
        tags: raw_recipe&.tags { |raw_tag| build_tag(raw_tag) },
      )
    end

    private def build_chef(raw_recipe)
      return nil unless raw_recipe

      Chef.new(
        id: raw_recipe.id,
        name: raw_recipe.name
      )
    end

    private def build_tag(raw_tag)
      return nil unless raw_tag

      Tag.new(
        id: raw_tag.id,
        name: raw_tag.name
      )
    end
  end
end
