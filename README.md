# mpv YouTube Search

This [mpv](https://github.com/mpv-player/mpv) script uses the built-in `mp.input()` to search YouTube.

This script requires mpv 0.38.0 or greater, for older versions of mpv see the [mpv-v0.37.0 branch](https://github.com/willswats/mpv-youtube-search/tree/mpv-v0.37.0).

This script works well with [mpv-playlistmanager](https://github.com/jonniek/mpv-playlistmanager), [mpv-gallery-view](https://github.com/occivink/mpv-gallery-view), or any other mpv playlist viewer as the search results are added to the mpv playlist.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Keybindings](#keybindings)

## Installation

In your mpv `config` directory, add `youtube-search.lua` to `scripts` and (optionally) add `youtube-search.conf` to `script-opts` (create the directories if they do not exist).

## Configuration

Change the values inside of `youtube-search.conf` to configure the script.

To add the key bindings to your `input.conf` (change `i` to your desired key):

```conf
i script-binding input_youtube_search_replace
i script-binding input_youtube_search_append
i script-binding input_search_results_update
```

## Keybindings

`ALT+s` - Open the input for searching YouTube and replacing the playlist with the search results

`Alt+a` - Open the input for searching YouTube and appending the search results to the playlist

`ALT+r` - Open the input for updating the number of search results
