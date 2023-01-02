local status_ok, fidget = pcall(require, "figet")
if not status_ok then
    return
end

fidget.setup()
