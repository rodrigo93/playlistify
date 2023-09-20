# frozen_string_literal: true

require_relative '../../../../lib/models/changes/add_song_to_playlist_change'
require 'json'

describe AddSongToPlaylistChange do
  describe '#apply_to' do
    subject { described_class.new(change_data).apply_to(output_data) }

    let(:playlist_id) { '1' }
    let(:song_id)     { '123' }

    let(:output_data) do
      {
        'playlists' => [
          { 'id' => '1', 'song_ids' => [] },
          { 'id' => '2', 'song_ids' => [] }
        ]
      }
    end

    let(:change_data) do
      {
        'playlist_id' => playlist_id,
        'song_id' => song_id
      }
    end

    it 'adds the song to the specified playlist' do
      subject

      playlist = output_data['playlists'].find { |p| p['id'] == playlist_id }

      expect(playlist['song_ids']).to include(song_id)
    end

    it 'does not add the song to other playlists' do
      subject

      playlists = output_data['playlists'].reject { |p| p['id'] == playlist_id }

      playlists.each do |playlist|
        expect(playlist['song_ids']).to be_empty
      end
    end
  end
end
