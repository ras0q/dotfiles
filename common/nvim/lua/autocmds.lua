-- TODO: migrate to lua syntax
-- git commit prefix
vim.cmd([[
augroup gitabbr
  autocmd!
  " ✨ fe: Introduce new features.
  autocmd FileType gitcommit iabbrev fe :sparkles:
  " 🐛 bu: Fix a bug.
  autocmd FileType gitcommit iabbrev bu :bug:
  " 🩹 ad: Simple fix for a non-critical issue.
  autocmd FileType gitcommit iabbrev ad :adhesive_bandage:
  " ♻️ re: Refactor code.
  autocmd FileType gitcommit iabbrev re :recycle:
  " 💥 bo: Introduce breaking changes.
  autocmd FileType gitcommit iabbrev bo :boom:
  " 🔥 rm: Remove code or files.
  autocmd FileType gitcommit iabbrev rm :fire:
  " ⏪️ rv: Revert changes.
  autocmd FileType gitcommit iabbrev rv :rewind:
  " 🎨 fo: Improve structure / format of the code.
  autocmd FileType gitcommit iabbrev fo :art:
  " 💄 ui: Add or update the UI and style files.
  autocmd FileType gitcommit iabbrev ui :lipstick:
  " 🔧 co: Add or update configuration files.
  autocmd FileType gitcommit iabbrev co :wrench:
  " 📝 do: Add or update documentation.
  autocmd FileType gitcommit iabbrev do :memo:
  " ⬆️ up: Upgrade dependencies.
  autocmd FileType gitcommit iabbrev up :arrow_up:
  " ✅ ch: Add, update, or pass tests."
  autocmd FileType gitcommit iabbrev ch :white_check_mark:
augroup END
]])
