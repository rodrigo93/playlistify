# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../../lib/models/changes/add_playlist_to_user_change'

RSpec.describe AddPlaylistToUserChange do
  describe '#apply_to' do
    subject { described_class.new(change_data).apply_to(output_data) }

    let(:user_id) { '1' }
    let(:playlist_id) { '1' }

    let(:output_data) do
      {
        'users' => [
          { 'id' => '1', 'name' => 'User1', 'playlists' => [] },
          { 'id' => '2', 'name' => 'User2', 'playlists' => [] }
        ],
        'playlists' => []
      }
    end

    let(:change_data) do
      {
        'user_id' => user_id,
        'playlist' => { 'id' => playlist_id, 'owner_id' => user_id }
      }
    end

    context 'when the user exists' do
      context 'and the playlist already exists for the user' do
        it 'logs that the playlist already exists and skips' do
          user_data = output_data['users'][0]
          user_data['playlists'] << { 'id' => playlist_id }

          expect { subject }.to output(
            "Playlist ##{playlist_id} already exists for user #1\nSkipping...\n"
          ).to_stdout

          expect(user_data['playlists'].size).to eq(1)
        end
      end

      context 'and the playlist does not exist for the user' do
        it 'adds the playlist to the user' do
          subject

          expect(output_data['users'].first['playlists'].size).to eq(1)
          expect(output_data['users'].first['playlists'].first['id']).to eq(playlist_id)
          expect(output_data['users'].first['playlists'].first['owner_id']).to eq(user_id)
        end
      end
    end

    context 'when the user does not exist' do
      let(:user_id) { '3333' }

      it 'logs that the user was not found and does not add the playlist' do
        expect { subject }.to output(
          "User ##{user_id} not found\nSkipping...\n"
        ).to_stdout

        expect(output_data['users'][0]['playlists']).to be_empty
      end
    end
  end
end
