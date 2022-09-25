local mp = require "mp"
local options = require "mp.options"

package.path = mp.command_native({"expand-path", "~~/script-modules/?.lua;"}) ..
                   package.path
local input = require "user-input-module"

local opts = {
    -- Key to open search
    key_open_search = "ALT+s",

    -- Number of search results
    search_results = 50
}

-- Read configuration file
options.read_options(opts, "youtube-search")

local function search_youtube(user_input)
    -- End if user_input does not exist or if user_input is an empty string (after removing whitespace)
    if not user_input or string.gsub(user_input, "%s+", "") == "" then return end

    local search_command = "ytdl://ytsearch"
    local search_query = opts.search_results .. ":" .. user_input

    mp.commandv("loadfile", search_command .. search_query)
end

local function open_search()
    input.get_user_input(search_youtube, {request_text = "Enter search text:"})
end

mp.add_key_binding(opts.key_open_search, "open_search", open_search)
