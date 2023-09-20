# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/playlistify'

RSpec.describe Playlistify do
  it 'prints temporary message' do
    expect { described_class.run }.to output("Ready to run!\n").to_stdout
  end
end
