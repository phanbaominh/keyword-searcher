# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern
  included do
    scope :named, ->(name) { where(name: name) }
  end
end
