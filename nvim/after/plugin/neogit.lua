local status_ok, neogit = pcall(require, "Neogit")
if not status_ok then
  return
end

neogit.setup({
  integrations = {
    diffview = true
  }
})
