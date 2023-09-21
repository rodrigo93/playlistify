# frozen_string_literal: true

require_relative 'lib/playlistify'

input_file  = ARGV[0]
change_file = ARGV[1]
output_file = ARGV[2]

app = Playlistify.new(input_file, change_file, output_file)
app.run
