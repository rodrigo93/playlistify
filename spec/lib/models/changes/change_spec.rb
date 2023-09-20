# frozen_string_literal: true

require 'spec_helper'

require 'json'
require_relative '../../../../lib/models/changes/change'

RSpec.describe Change do
  describe '.create' do
    subject { Change.create(action, change_data) }

    let(:data) do
      {
        'users' => [],
        'playlists' => []
      }
    end

    context 'when change action is "add_song_to_playlist"' do
      let(:action) { 'add_song_to_playlist' }
      let(:change_data) do
        {
          'data' => {
            'playlist_id' => '1',
            'song_id' => '123'
          }
        }
      end

      it { is_expected.to be_instance_of(AddSongToPlaylistChange) }
    end

    context 'when change action is "add_playlist_to_user"' do
      let(:action) { 'add_playlist_to_user' }
      let(:change_data) do
        {
          'data' => {
            'user_id' => '1',
            'playlist' => {
              'id' => '1',
              'owner_id' => '1',
              'song_ids' => []
            }
          }
        }
      end

      it { is_expected.to be_instance_of(AddPlaylistToUserChange) }
    end

    context 'when change action is "remove_playlist"' do
      let(:action) { 'remove_playlist' }

      let(:change_data) do
        {
          'data' => {
            'playlist_id' => '1'
          }
        }
      end

      it { is_expected.to be_instance_of(RemovePlaylistChange) }
    end

    context 'when change action is unsupported' do
      let(:action) { 'abc' }
      let(:change_data) do
        {
          'data' => {}
        }
      end

      it 'logs an error to console' do
        expect { subject }.to output(/Unsupported change action: #{action}/).to_stdout
      end
    end
  end
end
