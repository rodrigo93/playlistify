# Playlistify

Manage your spotify (or compatible) playlists directly from your console.

## About

This is a solution for [this coding challenge](https://gist.github.com/vitchell/a081703591116bab7e859cc000c98495)
powered by Ruby v3.

## Project Requirements

### Application

The input JSON file consists of a set of `users`, `songs`, and `playlists`
that are part of an online music service: [spotify.json](https://gist.githubusercontent.com/vitchell/fe0b1cb51e158058fb1b9d827584d01f/raw/f00f4d94d9d87b0d928bb3766a2667fb502d7407/spotify.json).

- [ ] Ingests `spotify.json`
- [ ] Ingests a `changes file`, which can take whatever form you like (we use
  `changes.json` in our example, but you’re free to name it whatever, and format
  it as text, YAML, CSV, or whatever)
- [ ] Outputs `output.json` in the same structure as `spotify.json`, with the
  changes applied. The types of changes you need to support are enumerated below

### Features
- [ ] Add an existing song to an existing playlist
- [ ] Add a new playlist for an existing user; the playlist should contain at
  least one existing song
- [ ] Remove an existing playlist

### README.md
- [ ] Explains how to use your application and a way to validate its output
- [ ] Describes what changes you would need to make in order to scale this
  application to handle very large input files and/or very large changes files.
  Just describe these changes — please do not implement a scaled-up version of
  the application.
- [ ] Includes any thoughts on design decisions you made that you think are
  appropriate.
- [ ] Includes how long you spent on the project, and any other thoughts you
  might have or want to communicate.

### Notes
- Don’t worry about creating a UI, DB, server, or deployment as a part of the
  code you're writing.
- Your code should be executable on Mac or Linux.

## How do I use this?

### Installation

_TODO_

### Usage

_TODO_

### Help

_TODO_

## Contributing

_TODO_

### Setup

_TODO_

### Testing

_TODO_

## Final Thoughts

_TODO_
