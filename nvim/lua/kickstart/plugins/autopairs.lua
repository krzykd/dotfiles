return {

	'windwp/nvim-autopairs',
	version = '0.11.0',
	event = 'InsertEnter',
	opts = {
		fast_wrap = {
			map = '<c-e>',
			chars = { '{', '[', '(', '"', "'" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			end_key = 'L',
			before_key = 'h',
			after_key = 'l',
			cursor_pos_before = true,
			keys = 'qwertyuiopzxcvbnmasdfghjkl',
			manual_position = true,
			highlight = 'Search',
			highlight_grey = 'Comment'
		},
	},

	-- {
	-- 	'saghen/blink.pairs',
	-- 	version = '0.5.0', -- (recommended) only required with prebuilt binaries
	--
	-- 	-- download prebuilt binaries from github releases
	-- 	dependencies = 'saghen/blink.download',
	-- 	-- OR build from source, requires nightly:
	-- 	-- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- 	-- build = 'cargo build --release',
	-- 	-- If you use nix, you can build from source using latest nightly rust with:
	-- 	-- build = 'nix run .#build-plugin',
	--
	-- 	--- @module 'blink.pairs'
	-- 	--- @type blink.pairs.Config
	-- 	opts = {}
	-- }
}
