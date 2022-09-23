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

local function search_youtube(search_input)
    if not search_input then return end
    mp.commandv("loadfile", "ytdl://ytsearch" .. opts.search_results .. ":" ..
                    search_input, "replace")
end

local function get_search_input()
    input.get_user_input(search_youtube,
                         {request_text = "Enter search text:", replace = true},
                         "replace")
end

mp.add_key_binding(opts.key_opensearch, "open-search", get_search_input)
