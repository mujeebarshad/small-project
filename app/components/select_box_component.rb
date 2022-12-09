# frozen_string_literal: true

class SelectBoxComponent < Components::Component
  attribute :select
  attribute :auto_width, default: false

  attr_reader :select
end
