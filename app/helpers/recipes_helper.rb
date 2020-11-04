module RecipesHelper
  def render_description(string)
    return '' if string.blank?

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(string).html_safe
  end

  def render_tags(tags)
    tags.join(", ")
  end
end
