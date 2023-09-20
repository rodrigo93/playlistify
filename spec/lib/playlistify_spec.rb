# frozen_string_literal: true

require 'spec_helper'

require 'json'
require 'tempfile'
require_relative '../../lib/playlistify'

RSpec.describe Playlistify do
  describe '#run' do
    subject do
      app = described_class.new(input_file, changes_file, output_file)
      app.run
    end

    let(:input_file)   { 'spec/fixtures/input.json' }
    let(:changes_file) { 'spec/fixtures/changes.json' }
    let(:output_file)  { 'temp/output.json' }

    let(:input_data)   { JSON.parse(File.read(input_file)) }
    let(:changes_data) { JSON.parse(File.read(changes_file)) }

    after { FileUtils.rm_f(output_file) }

    # TODO: Improve output_data assertions as they are not very readable nor maintainable
    it 'applies changes and saves the output' do
      subject

      output_data = JSON.parse(File.read(output_file))

      expect(output_data['users'].size).to eq(2)
      expect(output_data['playlists'].size).to eq(3) # Playlist #4 is invalid
      expect(output_data['playlists'][0]['song_ids']).to eq(%w[1 2 5])
      expect(output_data['playlists'][1]['song_ids']).to eq(%w[3 4 12])
      expect(output_data['playlists'][2]['song_ids']).to eq(%w[2 3 4])
    end
  end
end
