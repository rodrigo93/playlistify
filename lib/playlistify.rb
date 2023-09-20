# frozen_string_literal: true

require 'json'

require_relative 'models/changes/change'
require_relative 'models/changes/add_playlist_to_user_change'
require_relative 'models/changes/add_song_to_playlist_change'
require_relative 'models/changes/remove_playlist_change'

class Playlistify
  def initialize(input_file, changes_file, output_file)
    @input_file = input_file
    @changes_file = changes_file
    @output_file  = output_file
  end

  def run
    return if output_file_exists?

    load_output_data
    load_changes
    apply_changes
    save_output
  end

  private

  def apply_changes
    @changes.each do |change_data|
      change = Change.create(change_data['action'], change_data['data'])

      change.apply_to(@output_data)
    end
  end

  def load_changes
    @changes = JSON.parse(File.read(@changes_file))
  end

  def load_output_data
    @output_data = JSON.parse(File.read(@input_file))
  end

  def output_file_exists?
    return false unless File.exist?(@output_file)

    puts "Output file already exists: #{@output_file}"
    puts 'Aborting...'

    true
  end

  def save_output
    File.write(@output_file, JSON.pretty_generate(@output_data))
  end
end
