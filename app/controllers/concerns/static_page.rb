# frozen_string_literal: true

module StaticPage
  extend ActiveSupport::Concern

  included do
    before_action :indicate_static
  end

  def indicate_static
    @static_page = true
  end
end
