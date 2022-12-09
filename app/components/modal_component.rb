# frozen_string_literal: true

class ModalComponent < Components::Component
  CONTENT_CLASS_BASE = "modal__content"

  attribute :skip_header, default: false
  attribute :title
  attribute :content_only, default: false
  attribute :id
  attribute :content_classes, default: ""
  attribute :not_dismissable, default: false # Inverted naming because Components cannot handle false assignment

  has_one :body

  def content_classes
    [CONTENT_CLASS_BASE, @content_classes].join(" ")
  end
end
