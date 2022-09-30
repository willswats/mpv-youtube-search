# mpv YouTube Search <!-- omit in toc -->

This [mpv](https://github.com/mpv-player/mpv) script uses [mpv-user-input](https://github.com/CogentRedTester/mpv-user-input) to; search YouTube, play the top search result, and add the subsequent search results to the playlist.

This script works well with [playlist-manager](https://github.com/jonniek/mpv-playlistmanager), [mpv-gallery-view](https://github.com/occivink/mpv-gallery-view), or any other mpv playlist viewer as you can view the search results with them.

## Table of Contents <!-- omit in toc -->

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Keybindings](#keybindings)

## Features

- Search YouTube, play the top search result, and add the subsequent search results to the playlist.
- Specify the number of YouTube search results for a search by adding a number and a colon before your search query, for example: `100:hello world`.

## Installation

1. Follow the installation instructions for [mpv-user-input](https://github.com/CogentRedTester/mpv-user-input).
2. In your mpv `config` directory, add `youtube-search.lua` to `scripts` and (optionally) add `youtube-search.conf` to `script-opts` (create the directories if they do not exist).

## Configuration

Change the values inside of `youtube-search.conf` to configure the script.

## Keybindings

`ALT+s` - Open the input for searching youtube
