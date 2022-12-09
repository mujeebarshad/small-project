# frozen_string_literal: true

class TabBarComponent < Components::Component
  CLASS_BASE = "c-tab-bar"
  SECTION_CLASS_BASE = "c-tab-bar__tab"

  attribute :classes
  attribute :flush, default: false

  has_many :tabs do
    attribute :title
    attribute :url
    attribute :active, default: false
    attribute :data, default: {}

    def classes
      classes = [SECTION_CLASS_BASE]
      classes << "#{SECTION_CLASS_BASE}--active" if active
      classes.join(" ")
    end

    def data
      data = { target: "tab-bar.tab" }
      @data.merge(data)
    end
  end

  def active_tab_index
    tabs.find_index(&:active) || 0
  end

  def classes
    classes = [CLASS_BASE]
    classes << @classes
    classes << "#{CLASS_BASE}--flush" if flush
    classes.join(" ")
  end
end
