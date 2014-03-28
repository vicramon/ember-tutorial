module ApplicationHelper

  def markdown(text)
    renderer = HTMLwithPygments.new(filter_html: false)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      space_after_headers: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

end
