local M = {}
local function lock_terminal(buf)
	local opts = { buffer = buf, noremap = true, silent = true }

	vim.keymap.set("t", "<Esc><Esc>", "<Nop>", opts)
	vim.keymap.set("t", "<C-\\><C-n>", "<Nop>", opts)
end

function M.open(opts)
	opts = opts or {}

	local cmd = opts.cmd or { "tick" }
	if opts.path and opts.path ~= "" then
		table.insert(cmd, vim.fn.expand(opts.path))
	end

	local old_timeoutlen = vim.o.timeoutlen
	vim.o.timeoutlen = 10
	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
		row = math.floor(vim.o.lines * 0.1),
		col = math.floor(vim.o.columns * 0.1),
		style = "minimal",
		border = "rounded",
	})
	local function resize_win()
		if not vim.api.nvim_win_is_valid(win) then
			return
		end

		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)

		vim.api.nvim_win_set_config(win, {
			relative = "editor",
			width = width,
			height = height,
			row = math.floor((vim.o.lines - height) / 2),
			col = math.floor((vim.o.columns - width) / 2),
		})
		vim.api.nvim_set_current_win(win)
	end

	vim.fn.jobstart(cmd, {
		term = true,
		on_exit = function()
			vim.schedule(function()
				vim.o.timeoutlen = old_timeoutlen
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
			end)
		end,
	})
	vim.api.nvim_create_autocmd("VimResized", {
		buffer = buf,
		callback = resize_win,
	})
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	lock_terminal(buf)
	vim.cmd("startinsert")
end

return M
