local mp = require "mp"
local options = require "mp.options"
local input = require "mp.input"

local opts = {
  -- Key to open the input for searching YouTube and replacing the playlist with the search results
  key_youtube_search_replace = "ALT+s",

  -- Key to open the input for searching YouTube and appending the search results to the playlist
  key_youtube_search_append = "ALT+a",

  -- Key to open the input for updating the number of search results
  key_search_results_update = "ALT+r",

  -- Default number of search results
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
  local str_new = string.gsub(str, "%s+", "")
  return str_new
end

-- Search YouTube
local function youtube_search(user_input, flag)
  if not user_input then
    return
  elseif is_whitespace(user_input) then
    mp.osd_message("Error: Input must include text",
      opts.osd_message_duration)
    return
  end

  local search_command = "ytdl://ytsearch" .. opts.search_results .. ":"

  mp.commandv("loadfile", search_command .. user_input, flag)

  local action = ""
  if flag == "replace" then
    action = "replaced"
  elseif flag == "append-play" then
    action = "appended"
  end

  mp.osd_message("Added" .. " (" .. action .. ") " .. opts.search_results ..
    " search result/s for " .. quote(user_input) .. " to the playlist",
    opts.osd_message_duration)
end

-- Update the number of search results
local function search_results_update(user_input)
  if not user_input then
    return
  elseif is_number(user_input) == false then
    mp.osd_message("Error: Input must be a number",
      opts.osd_message_duration)
    return
  elseif (tonumber(user_input) < 1) then
    mp.osd_message("Error: Input must be greater than or equal to 1",
      opts.osd_message_duration)
    return
    -- Prevent math.floor() converting to scientific notation
  elseif #user_input > 14 then
    mp.osd_message("Error: Input must be less than 14 characters",
      opts.osd_message_duration)
    return
  end

  -- Floor to prevent decimals
  local search_results_new = remove_whitespace(tostring(math.floor(user_input)))

  mp.osd_message(" Number of search results set to " ..
    quote(search_results_new), opts.osd_message_duration)

  opts.search_results = search_results_new
end

-- Open the input for searching YouTube and replacing the playlist with the search results
local function input_youtube_search_replace()
  input.get({
    prompt = "Enter search input (replace):",
    submit = function(user_input)
      youtube_search(user_input, "replace")
      input.terminate()
    end
  })
end

-- Open the input for searching YouTube and appending the search results to the playlist
local function input_youtube_search_append()
  input.get({
    prompt = "Enter search input (append):",
    submit = function(user_input)
      youtube_search(user_input, "append-play")
      input.terminate()
    end
  })
end

-- Open the input for updating the number of search results
local function input_search_results_update()
  input.get({
    prompt = "Enter number of search results:",
    submit = function(user_input)
      search_results_update(user_input)
      input.terminate()
    end
  })
end

-- Add key bindings
mp.add_key_binding(
  opts.key_youtube_search_replace,
  "youtube_search_replace",
  input_youtube_search_replace
)
mp.add_key_binding(
  opts.key_youtube_search_append,
  "youtube_search_append",
  input_youtube_search_append
)
mp.add_key_binding(
  opts.key_search_results_update,
  "search_results_update",
  input_search_results_update
)
