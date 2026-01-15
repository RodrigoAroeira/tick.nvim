local M = {}

function M.open(opts)
	opts = opts or {}

	local cmd = opts.cmd or { "tick" }

	local buf = vim.api.nvim_create_buf(false, true)

	local width = math.floor(vim.o.columns * (opts.width or 0.9))
	local height = math.floor(vim.o.lines * (opts.height or 0.9))

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = opts.border or "rounded",
	})

	local chan = vim.api.nvim_open_term(buf, {})

	vim.system(cmd, {
		pty = true,
		stdin = chan,
		stdout = chan,
		stderr = chan,
	}, function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end)

	vim.cmd("startinsert")
end

return M
