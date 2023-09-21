# frozen_string_literal: true

require 'spec_helper'

require_relative '../../../../lib/models/changes/add_playlist_to_user_change'

RSpec.describe AddPlaylistToUserChange do
  describe '#apply_to' do
    subject { described_class.new(change_data).apply_to(output_data) }

    let(:user_id)     { '1' }
    let(:playlist_id) { '1' }
    let(:song_ids)    { %w[1 3] }

    let(:output_data) do
      {
        'users' => [
          { 'id' => '1', 'name' => 'User1' },
          { 'id' => '2', 'name' => 'User2' }
        ],
        'playlists' => [],
        'songs' => [
          { 'id' => '1', 'title' => 'Song 1' },
          { 'id' => '2', 'title' => 'Song 2' },
          { 'id' => '3', 'title' => 'Song 3' }
        ]
      }
    end

    let(:change_data) do
      {
        'user_id' => user_id,
        'playlist' => {
          'id' => playlist_id,
          'owner_id' => user_id,
          'song_ids' => song_ids
        }
      }
    end

    context 'when the user exists' do
      context 'and the playlist already exists for the user' do
        let(:output_data) do
          {
            'users' => [
              { 'id' => '1', 'name' => 'User1' },
              { 'id' => '2', 'name' => 'User2' }
            ],
            'playlists' => [
              { 'id' => playlist_id, 'owner_id' => user_id, 'song_ids' => song_ids }
            ]
          }
        end

        it 'logs that the playlist already exists and skips' do
          expect { subject }.to output(
            "Playlist ##{playlist_id} already exists for user #1\nSkipping...\n"
          ).to_stdout

          expect(output_data['playlists'].size).to eq(1)
        end
      end

      context 'and the wrong owner_id is informed' do
        let(:change_data) do
          super()['playlist'].merge!('owner_id' => '333')
          super()
        end

        it 'adds the playlist to the user with correct owner_id' do
          subject

          expect(output_data['playlists'].size).to eq(1)
          expect(output_data['playlists'].first['id']).to eq(playlist_id)
          expect(output_data['playlists'].first['owner_id']).to eq(user_id)
        end
      end

      context 'and the playlist does not exist for the user' do
        it 'adds the playlist to the user' do
          subject

          expect(output_data['playlists'].size).to eq(1)
          expect(output_data['playlists'].first['id']).to eq(playlist_id)
          expect(output_data['playlists'].first['owner_id']).to eq(user_id)
          expect(output_data['playlists'].first['song_ids']).to eq(song_ids)
        end
      end

      context 'and song_ids is "nil"' do
        let(:song_ids) { nil }

        it 'skips adding the playlist and logs a message' do
          expect { subject }.to output(
            "Skipping playlist ##{playlist_id} because it's empty\n"
          ).to_stdout

          expect(output_data['playlists']).to be_empty
        end
      end

      context 'and song_ids is "empty"' do
        let(:song_ids) { [] }

        it 'skips adding the playlist and logs a message' do
          expect { subject }.to output(
            "Skipping playlist ##{playlist_id} because it's empty\n"
          ).to_stdout

          expect(output_data['playlists']).to be_empty
        end
      end

      context "and some song doesn't exist" do
        let(:song_ids) { %w[1 2 789] }

        it 'skips adding the playlist and logs a message' do
          expect { subject }.to output(
            "Skipping playlist #1 because it has invalid songs: 789\n"
          ).to_stdout

          expect(output_data['playlists']).to be_empty
        end
      end
    end

    context 'when the user does not exist' do
      let(:user_id) { '3333' }

      it 'logs that the user was not found and does not add the playlist' do
        expect { subject }.to output(
          "User ##{user_id} not found\nSkipping...\n"
        ).to_stdout

        expect(output_data['playlists']).to be_empty
      end
    end
  end
end
