# frozen_string_literal: true

require_relative 'change'

class AddPlaylistToUserChange < Change
  def apply_to(output_data)
    user_data = user(output_data)

    unless user_data
      puts "User ##{user_id} not found"
      puts 'Skipping...'
      return
    end

    return if playlist_exists?(output_data)
    return unless valid_song_ids?(output_data)

    output_data['playlists'] << playlist
  end

  private

  # Merges the playlist data with the user_id even if 'owner_id' is informed
  # incorrectly in the changes file
  def playlist
    @playlist ||= @data['playlist'].merge('owner_id' => user_id)
  end

  def playlist_exists?(output_data)
    return false unless output_data['playlists'].any? { |p| p['id'] == playlist['id'] }

    puts "Playlist ##{playlist['id']} already exists for user ##{user_id}"
    puts 'Skipping...'
    true
  end

  def user_id
    @user_id ||= @data['user_id']
  end

  def user(output_data)
    @user ||= output_data['users'].find { |u| u['id'] == user_id }
  end

  # rubocop:disable Metrics/MethodLength
  def valid_song_ids?(output_data)
    playlist_song_ids = playlist['song_ids']

    if playlist_song_ids.nil? || playlist_song_ids.empty?
      puts "Skipping playlist ##{playlist['id']} because it's empty"
      return false
    end

    invalid_songs = playlist_song_ids - output_data['songs'].map { |s| s['id'] }

    unless invalid_songs.empty?
      puts "Skipping playlist ##{playlist['id']} because it has invalid songs: #{invalid_songs.join(', ')}"
      return false
    end

    true
  end
  # rubocop:enable Metrics/MethodLength
end
