# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern
  included do |base|
    scope :named, ->(name) { where("#{base.table_name}.name LIKE ?", "%#{name}%") }
  end
end
