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

    return if playlist_exists?(user_data)
    return unless valid_song_ids?(playlist)

    user_data['playlists'] << playlist
  end

  private

  # Merges the playlist data with the user_id even if 'owner_id' is informed
  # incorrectly in the changes file
  def playlist
    @playlist ||= @data['playlist'].merge('owner_id' => user_id)
  end

  def playlist_exists?(user_data)
    return false unless user_data['playlists'].any? { |p| p['id'] == playlist['id'] }

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

  def valid_song_ids?(playlist)
    if playlist['song_ids'].nil? || playlist['song_ids'].empty?
      puts "Skipping playlist ##{playlist['id']} because it's empty"
      return false
    end

    true
  end
end
