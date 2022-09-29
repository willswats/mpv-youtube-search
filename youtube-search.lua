local mp = require "mp"
local options = require "mp.options"

package.path = mp.command_native({"expand-path", "~~/script-modules/?.lua;"}) ..
                   package.path
local input = require "user-input-module"

local opts = {
    -- Key to open the input for searching youtube
    key_search_youtube = "ALT+s",

    -- Number of search results
    search_results = 50,

    -- Duration of osd messages
    osd_message_duration = 5
}

-- Read configuration file
options.read_options(opts, "youtube-search")

-- Check if string is whitespace
local function is_whitespace(str)
    if string.gsub(str, "%s+", "") == "" then
        return true
    else
        return false
    end
end

local function search_youtube()
    input.get_user_input(function(user_input)
        if not user_input then
            return
        elseif is_whitespace(user_input) then
            mp.osd_message("Error: Input must include text",
                           opts.osd_message_duration)
            return
        end

        local search_command = "ytdl://ytsearch"
        local search_query = opts.search_results .. ":" .. user_input

        mp.commandv("loadfile", search_command .. search_query)
    end, {request_text = "Enter search text:"})
end

-- Add key bindings
mp.add_key_binding(opts.key_search_youtube, "search_youtube", search_youtube)
