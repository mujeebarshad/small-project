# frozen_string_literal: true

class ContextMenuComponent < Components::Component
  DROP_CLASS_BASE = "c-context-menu__drop"

  attribute :id
  attribute :classes
  attribute :data, default: {}

  def data
    @data[:controller] = @data[:controller].to_s + " context-menu"
    @data[:target] = @data[:target].to_s + " context-menu.menu"
    @data
  end

  has_one :toggle do
    attribute :data, default: {}
    attribute :classes, default: "btn"
  end

  has_one :drop do
    attribute :modifiers, default: %w[bottom left]

    def modifiers
      (@modifiers.map { |c| DROP_CLASS_BASE + "--#{c}" } << DROP_CLASS_BASE).join(" ")
    end
  end
end
