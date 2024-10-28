require("lualine").setup({
	options = {
		icons_enabled = false,
		always_divide_middle = false;
		component_separators = { left = '', right = ''},
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{
				'filename',
				file_status = true,
				newfile_status = false,
				path = 4,
				symbols = {
					modified = '[!]',
					readonly = '[X]',
					unnamed = '[?]',
				}
			}
		},
		lualine_c = {
			'diagnostics',
		},
		lualine_x = {
		},
		lualine_y = {
			'branch',
			'diff',
		},
		lualine_z = {
			'location',
		},
	};
})
