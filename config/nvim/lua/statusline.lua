local custom_statusline =
  "%f%< %q%h%w%m%r"
  .."%="
  .."%y"
  .."%{&fileencoding != '' ? '['.&fileencoding.']' : ''}"
  .."[%b 0x%B]"
  .." "
  .."%l:%c"
  .." "
  .."%#PmenuSel#"
  .."%{FugitiveStatusline()}"
  .."%#LineNr#"

vim.opt.laststatus = 2
vim.opt.statusline = custom_statusline

vim.cmd('highlight StatusLine ctermfg=022')
vim.cmd('highlight StatusLineNC ctermfg=250')
