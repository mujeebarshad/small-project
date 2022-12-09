# frozen_string_literal: true

class OrganizationFactory
  class << self
    def build(attributes = {})
      Organization.new({
        name: "Lorem ipsum"
      }.merge(attributes))
    end

    def create(attributes = {})
      build(attributes).tap(&:save!)
    end
  end
end
