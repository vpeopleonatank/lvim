local M = {}

M.config = function()
  vim.g.slime_target = 'tmux'
  vim.g.slime_python_ipython = 1
  SOCKET_NAME = ""
  if os.getenv("TMUX") ~= nil then
    for w in os.getenv("TMUX"):gmatch("([^,]+)") do
      SOCKET_NAME = w
      break
    end
  else
    SOCKET_NAME = "default"
  end

  vim.g.slime_default_config = {
              --socket_name= '/tmp//tmux-1000/default',
              socket_name= SOCKET_NAME,
              target_pane= ':.2' }
  vim.g.slime_dont_ask_default = 1
  
end

return M
