# frozen_string_literal: true

class Playlist
  attr_accessor :id, :owner_id, :song_ids

  def initialize(id:, owner_id:, song_ids:)
    @id       = id
    @owner_id = owner_id
    @song_ids = song_ids
  end
end
