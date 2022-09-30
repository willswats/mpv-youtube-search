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

-- Check if string is number
local function is_number(str)
    if type(tonumber(str)) == "number" then
        return true
    else
        return false
    end
end

-- Remove whitespace from string
local function remove_whitespace(str)
    local new_str = string.gsub(str, "%s+", "")
    return new_str
end

-- Seperates a string into two strings at the first colon
local function split_at_first_colon(str)
    local str1, str2 = string.match(str, "(.-):(.-)$")
    return str1, str2
end

local function search_youtube()
    input.get_user_input(function(user_input)
        if not user_input then
            return
        elseif is_whitespace(user_input) then
            mp.osd_message("Error: user_input must include text",
                           opts.osd_message_duration)
            return
        end

        local search_command_start = "ytdl://ytsearch"
        local search_command_end = opts.search_results .. ":" .. user_input

        local search_results, search_query = split_at_first_colon(user_input)

        if is_number(search_results) then
            local clean_search_results = remove_whitespace(search_results)

            if tonumber(clean_search_results) < 1 then
                mp.osd_message(
                    "Error: search_results must be greater than or equal to 1",
                    opts.osd_message_duration)
                return
            elseif #clean_search_results > 16 then
                mp.osd_message(
                    "Error: search_results must be less than 16 characters",
                    opts.osd_message_duration)
                return
            end

            search_command_end = tostring(math.floor(clean_search_results)) ..
                                     ":" .. search_query
        end

        mp.commandv("loadfile", search_command_start .. search_command_end)
    end, {request_text = "Enter search text:"})
end

-- Add key binding
mp.add_key_binding(opts.key_search_youtube, "search_youtube", search_youtube)
