# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../../lib/models/changes/remove_playlist_change'

RSpec.describe RemovePlaylistChange do
  describe '#apply_to' do
    subject { described_class.new(change_data).apply_to(output_data) }

    let(:playlist_id) { '1' }

    let(:output_data) do
      {
        'playlists' => [
          { 'id' => '1', 'owner_id' => '1' },
          { 'id' => '2', 'owner_id' => '2' }
        ]
      }
    end

    let(:change_data) do
      {
        'playlist_id' => playlist_id
      }
    end

    context 'when the playlist exists' do
      it 'removes the playlist from output_data' do
        expect { subject }.to change {
          output_data['playlists'].size
        }.from(2).to(1)

        expect(output_data['playlists']).not_to include({ 'id' => playlist_id })
      end
    end

    context 'when the playlist does not exist' do
      let(:playlist_id) { '3' }

      it 'does not change the output_data' do
        expect { subject }.not_to(change { output_data['playlists'].size })

        expect(output_data['playlists']).to include({ 'id' => '1', 'owner_id' => '1' })
        expect(output_data['playlists']).to include({ 'id' => '2', 'owner_id' => '2' })
      end
    end
  end
end
