return {
	-- INFO: increment/decrement
	'monaqa/dial.nvim',
	tag = 'v0.5.1',
	keys = {
		{ "<C-a>",  "<Plug>(dial-increment)",  mode = { "n", "v" }, desc = 'Increment (monaqa/dial)' },
		{ "<C-x>",  "<Plug>(dial-decrement)",  mode = { "n", "v" }, desc = 'Decrement (monaqa/dial)' },
		{ "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true,                    desc = 'Increment (monaqa/dial)' },
		{ "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true,                    desc = 'Decrement (monaqa/dial)' },
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex,  -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.constant.alias.bool, -- boolean value (true <-> false)
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/18)
				augend.date.alias["%Y-%m-%d"], -- date (2022-02-18)
				augend.date.alias["%H:%M"],
				augend.date.alias["%H:%M:%S"],
				augend.semver.alias.semver, -- 0.3.0, 1.22.1, 3.9.1,
				augend.date.new({
					pattern = "%m.%d.%Y",
					default_kind = "day",
					only_valid = true,
					word = false,
				}),
				augend.misc.alias.markdown_header,
			},
		})
	end,
}
