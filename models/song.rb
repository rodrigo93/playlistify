# frozen_string_literal: true

class Song
  attr_accessor :artist, :id, :name

  def initialize(id:, artist:, name:)
    @id     = id
    @name   = name
    @artist = artist
  end
end
