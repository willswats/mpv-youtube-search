# mpv YouTube Search

This [mpv](https://github.com/mpv-player/mpv) script uses the built-in `mp.input()` to search YouTube or YouTube Music and add the results to the playlist.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Keybindings](#keybindings)

## Installation

This script requires mpv `0.38.0` or greater, for older versions of mpv see the [mpv-v0.37.0 branch](https://github.com/willswats/mpv-youtube-search/tree/mpv-v0.37.0).

1. Install [yt-dlp](https://github.com/yt-dlp/yt-dlp).
2. In your mpv `config` directory, add `youtube-search.lua` to `scripts` and (optionally) add `youtube-search.conf` to `script-opts` (create the directories if they do not exist).

## Configuration

Change the values inside of `youtube-search.conf` to configure the script.

To add the key bindings to your `input.conf` (change `i` to your desired key):

```conf
i script-binding youtube_search/youtube_search_replace
i script-binding youtube_search/youtube_music_search_replace
i script-binding youtube_search/youtube_search_append
i script-binding youtube_search/youtube_music_search_append
i script-binding youtube_search/search_results_update
```

## Keybindings

`ALT+s` - Open the input for searching YouTube and replacing the playlist with the search results

`ALT+S` - Open the input for searching YouTube Music and replacing the playlist with the search results

`Alt+a` - Open the input for searching YouTube and appending the search results to the playlist

`ALT+A` - Open the input for searching YouTube Music and appending the search results to the playlist

`ALT+r` - Open the input for setting the number of search results (does not work with YouTube Music)
