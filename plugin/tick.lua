vim.api.nvim_create_user_command("Tick", function(opts)
	require("tick").open({
		path = opts.args ~= "" and opts.args or nil,
	})
end, {
	nargs = "?",
	complete = "file",
})

vim.keymap.set("n", "<leader>Tg", "<cmd>Tick<cr>", {
	desc = "Open tick global file",
})

vim.keymap.set("n", "<leader>Th", "<cmd>Tick .<cr>", {
	desc = "Open tick in the current dir",
})
