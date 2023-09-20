# frozen_string_literal: true

# TODO: Validate if songs exist
class AddSongToPlaylistChange < Change
  def apply_to(output_data)
    playlist = output_data['playlists'].find { |p| p['id'] == playlist_id }
    playlist['song_ids'] << song_id
  end

  private

  def playlist_id
    @playlist_id ||= @data['playlist_id']
  end

  def song_id
    @song_id ||= @data['song_id']
  end
end
