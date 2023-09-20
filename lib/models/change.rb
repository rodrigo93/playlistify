# frozen_string_literal: true

class Change
  attr_accessor :action, :data

  def initialize(action:, data:)
    @action = action
    @data   = data
  end
end
