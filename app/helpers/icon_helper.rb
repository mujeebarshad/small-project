# frozen_string_literal: true

module IconHelper
  def logo(height: 23, width: 82, classes: "")
    icon("seably", height: height, width: width, classes: classes)
  end

  # rubocop:disable Metrics/ParameterLists
  def icon(name, classes: "", size: nil, width: nil, height: nil, data: nil)
    width = size if size.present?
    height = size if size.present?
    style = "width: #{width}px; height: #{height}px" if width.present? || height.present?

    content_tag :svg, class: "icon #{classes}", style: style, data: data do
      "<use xlink:href=\"#icons-#{name}\">".html_safe
    end
  end
  # rubocop:enable Metrics/ParameterLists
end
