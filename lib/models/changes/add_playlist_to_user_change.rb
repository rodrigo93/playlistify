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

    if playlist_exists?(user_data)
      puts "Playlist ##{playlist['id']} already exists for user ##{user_id}"
      puts 'Skipping...'
      return
    end

    user_data['playlists'] << playlist
  end

  private

  def playlist
    @playlist ||= @data['playlist']
  end

  def playlist_exists?(user_data)
    user_data['playlists'].any? { |p| p['id'] == playlist['id'] }
  end

  def user_id
    @user_id ||= @data['user_id']
  end

  def user(output_data)
    @user ||= output_data['users'].find { |u| u['id'] == user_id }
  end
end
