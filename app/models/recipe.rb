class Recipe
  include ActiveModel::Model

  attr_accessor :id
  attr_accessor :title
  attr_accessor :image_url
  attr_accessor :description
  attr_accessor :chef
  attr_accessor :tags

  delegate :name, to: :chef, prefix: true

  def tags_list
    return [] if tags.blank?

    tags.map(&:name)
  end
end
