# frozen_string_literal: true

Rails.configuration.before_configuration do
  require "core_extensions/markdown_handler_monkey_patch"
end
