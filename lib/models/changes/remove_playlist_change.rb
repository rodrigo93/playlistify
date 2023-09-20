# frozen_string_literal: true

class RemovePlaylistChange < Change
  def apply_to(output_data)
    playlist_id = @data['playlist_id']

    output_data['playlists'].reject! { |p| p['id'] == playlist_id }
  end
end
