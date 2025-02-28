--- @sync entry
return {
  setup = function()
    ps.sub("cd", function()
      local dir = tostring(cx.active.current.cwd)
      for _, keyword in ipairs({
        "Downloads",
      }) do
        if string.find(dir, keyword) then
          return ya.manager_emit("sort", { "mtime", reverse = true, dir_first = true })
        end
      end
      return ya.manager_emit("sort", { "natural", reverse = false, dir_first = true })
    end)
  end,
}
