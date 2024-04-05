set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << END
local config = require('lualine').get_config()
config.options.theme = 'wombat'
config.sections.lualine_c = { '%f', 'filetype' }
config.sections.lualine_x = { 'encoding' }
config.sections.lualine_y = { 'progress', '%l/%L' }

require('lualine').setup(config)
END
