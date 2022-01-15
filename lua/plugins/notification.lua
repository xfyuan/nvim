local notify = require('notify')

require('notify').setup({
  timeout = 1250,
  icons = {
    ERROR = '',
    WARN = '',
    INFO = '',
    DEBUG = '',
    TRACE = '',
  },
  background_colour = '#282C34',
})

vim.notify = notify
