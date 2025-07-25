local opts = {
  noremap = true,
  silent = true,
  buffer = true,
}

-- ✨ fe: Introduce new features.
vim.keymap.set("i", "fe ", ":sparkles: ", opts)
-- 🐛 bu: Fix a bug.
vim.keymap.set("i", "bu ", ":bug: ", opts)
-- 🩹 ad: Simple fix for a non-critical issue.
vim.keymap.set("i", "ad ", ":adhesive_bandage: ", opts)
-- ♻️ re: Refactor code.
vim.keymap.set("i", "re ", ":recycle: ", opts)
-- 💥 bo: Introduce breaking changes.
vim.keymap.set("i", "bo ", ":boom: ", opts)
-- 🔥 rm: Remove code or files.
vim.keymap.set("i", "rm ", ":fire: ", opts)
-- ⏪️ rv: Revert changes.
vim.keymap.set("i", "rv ", ":rewind: ", opts)
-- 🎨 fo: Improve structure / format of the code.
vim.keymap.set("i", "fo ", ":art: ", opts)
-- 💄 ui: Add or update the UI and style files.
vim.keymap.set("i", "ui ", ":lipstick: ", opts)
-- 🔧 co: Add or update configuration files.
vim.keymap.set("i", "co ", ":wrench: ", opts)
-- 📝 do: Add or update documentation.
vim.keymap.set("i", "do ", ":memo: ", opts)
-- ⬆️ up: Upgrade dependencies.
vim.keymap.set("i", "up ", ":arrow_up: ", opts)
-- ✅ ch: Add, update, or pass tests.
vim.keymap.set("i", "ch ", ":white_check_mark: ", opts)
