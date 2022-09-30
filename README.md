# mpv YouTube Search <!-- omit in toc -->

This [mpv](https://github.com/mpv-player/mpv) script uses [mpv-user-input](https://github.com/CogentRedTester/mpv-user-input) to search YouTube.

The YouTube search results are added to the mpv playlist, therefore, this script works well with [mpv-playlistmanager](https://github.com/jonniek/mpv-playlistmanager), [mpv-gallery-view](https://github.com/occivink/mpv-gallery-view), or any other mpv playlist viewer.

## Table of Contents <!-- omit in toc -->

- [Installation](#installation)
- [Configuration](#configuration)
- [Keybindings](#keybindings)

## Installation

1. Follow the installation instructions for [mpv-user-input](https://github.com/CogentRedTester/mpv-user-input).
2. In your mpv `config` directory, add `youtube-search.lua` to `scripts` and (optionally) add `youtube-search.conf` to `script-opts` (create the directories if they do not exist).

## Configuration

Change the values inside of `youtube-search.conf` to configure the script.

To add the keybindings to your `input.conf` (change `i` to your desired key):

```conf
i script-binding youtube_search_replace
i script-binding youtube_search_append
i script-binding search_results_update
```

## Keybindings

`ALT+s` - Open the input for searching YouTube and replacing the playlist with the search results

`Alt+a` - Open the input for searching YouTube and appending the search results to the playlist

`ALT+r` - Open the input for updating the number of search results
