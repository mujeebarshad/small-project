# frozen_string_literal: true

require "components"

Components::MarkdownHandler.class_eval do
  def self.call(_template, source)
    @markdown_renderer ||= Redcarpet::Markdown.new(
      Components::MarkdownRenderer,
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    )
    "#{@markdown_renderer.render(source).inspect}.html_safe"
  end
end
