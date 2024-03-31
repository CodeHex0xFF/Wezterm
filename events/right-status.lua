local wezterm = require('wezterm')
local math = require('utils.math')
local M = {}

M.separator_char = ''

M.colors = {
   date_fg = '#7F82BB',
   date_bg = '#0F2536',
   battery_fg = '#BB49B3',
   battery_bg = '#0F2536',
   separator_fg = '#786D22',
   separator_bg = '#0F2536',
}

M.cells = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
M.push = function(text, icon, fg, bg, separate)
   table.insert(M.cells, { Foreground = { Color = fg } })
   table.insert(M.cells, { Background = { Color = bg } })
   table.insert(M.cells, { Attribute = { Intensity = 'Bold' } })
   table.insert(M.cells, { Text = icon .. ' ' .. text .. ' ' })

   if separate then
      table.insert(M.cells, { Foreground = { Color = M.colors.separator_fg } })
      table.insert(M.cells, { Background = { Color = M.colors.separator_bg } })
      table.insert(M.cells, { Text = M.separator_char })
   end

   table.insert(M.cells, 'ResetAttributes')
end

M.set_date = function()
   local date = wezterm.strftime(' %a  %Y-%m-%d %H:%M:%S')
   M.push(date, '', M.colors.date_fg, M.colors.date_bg, true)
end

M.setup = function()
   wezterm.on('update-right-status', function(window, _pane)
      M.cells = {}
      M.set_date()
      window:set_right_status(wezterm.format(M.cells))
   end)
end

return M
