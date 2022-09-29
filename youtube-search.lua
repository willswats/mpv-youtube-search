local mp = require "mp"
local options = require "mp.options"

package.path = mp.command_native({"expand-path", "~~/script-modules/?.lua;"}) ..
                   package.path
local input = require "user-input-module"

local opts = {
    -- Key to open the input for searching youtube
    key_search_youtube = "ALT+s",

    -- Key to open the input for updating the number of search results
    key_update_search_results = "ALT+S",

    -- Number of search results
    search_results = 50,

    -- Duration of osd messages
    osd_message_duration = 5
}

-- Read configuration file
options.read_options(opts, "youtube-search")

-- Add quotes to string
local function quote(str) return "\"" .. str .. "\"" end

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

-- Round string to nearest integer
local function round(str)
    local new_str = string.format("%.0f", str)
    return new_str
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

local function update_search_results()
    input.get_user_input(function(user_input)
        if not user_input then
            return
        elseif is_whitespace(user_input) or is_number(user_input) == false then
            mp.osd_message("Error: Input must be a number",
                           opts.osd_message_duration)
            return
        elseif (tonumber(user_input) < 1) then
            mp.osd_message("Error: Input must be greater than 0",
                           opts.osd_message_duration)
            return
        elseif #user_input > 16 then
            mp.osd_message("Error: Input must be less than 16 characters",
                           opts.osd_message_duration)
            return
        end

        local new_search_results = round(remove_whitespace(user_input))

        mp.osd_message("Number of search results set to " ..
                           quote(new_search_results), opts.osd_message_duration)

        opts.search_results = new_search_results
    end, {request_text = "Enter number of search results:"})
end

-- Add key bindings
mp.add_key_binding(opts.key_search_youtube, "search_youtube", search_youtube)
mp.add_key_binding(opts.key_update_search_results, "update_search_results",
                   update_search_results)
