# frozen_string_literal: true

class BannerComponent < Components::Component
  attribute :message
  attribute :type

  def icon
    case type
    when "danger"
      "close"
    end
  end

  def icon_classes
    case type
    when "success"
      "icon--checkmark-green"
    when "danger"
      "icon--close-red"
    end
  end
end
