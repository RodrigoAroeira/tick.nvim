local M = {}

function M.check()
	local health = vim.health or require("vim.health")
	health.start("binary")
	local binary_name = "tick"
	local msg = "Binary `" .. binary_name .. "` is"
	local fn
	if vim.fn.executable(binary_name) == 1 then
		fn = health.ok
	else
		fn = health.error
		msg = msg .. " not"
	end
	fn(msg .. " present")
end

return M
