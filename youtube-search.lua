local mp = require "mp"
local options = require "mp.options"

package.path = mp.command_native({"expand-path", "~~/script-modules/?.lua;"}) ..
                   package.path
local input = require "user-input-module"

local opts = {
    -- Key to open search
    key_opensearch = "ALT+s",

    -- Number of search results
    search_results = 50
}

options.read_options(opts, "youtube-search")

local function search_youtube(user_input)
    if not user_input then return end
    local search_command = "ytdl://ytsearch"
    local search_query = opts.search_results .. ":" .. user_input
    mp.commandv("loadfile", search_command .. search_query, "replace")
end

local function open_search()
    local get_user_input_options = {
        request_text = "Enter search text:",
        replace = true
    }
    input.get_user_input(search_youtube, get_user_input_options, "replace")
end

mp.add_key_binding(opts.key_opensearch, "open-search", open_search)
