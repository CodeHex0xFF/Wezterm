local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'wsl.exe'}
   options.launch_menu = {
         }
end

return options
