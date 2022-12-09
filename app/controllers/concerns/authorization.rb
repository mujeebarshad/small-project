# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
  end
end
