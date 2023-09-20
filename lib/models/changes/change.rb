# frozen_string_literal: true

class Change
  attr_accessor :action, :data

  class << self
    def create(action, change_data)
      case action.to_sym
      when :add_song_to_playlist
        AddSongToPlaylistChange.new(change_data)
      when :add_playlist_to_user
        AddPlaylistToUserChange.new(change_data)
      when :remove_playlist
        RemovePlaylistChange.new(change_data)
      else
        puts "Unsupported change action: #{action}"
      end
    end
  end

  def initialize(data)
    @data = data
  end

  def apply_to(_output_data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
