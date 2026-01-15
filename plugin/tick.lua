vim.api.nvim_create_user_command("Tick", function()
	require("tick").open()
end, {})

vim.keymap.set("n", "<leader>T", "<cmd>Tick<cr>", {
	desc = "Open tick",
})
