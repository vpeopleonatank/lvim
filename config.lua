--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- *
-- Settings
-- *
-- *
-- Settings
-- *
local init_custom_options = function()
	local custom_options = {
		relativenumber = true, -- Set relative numbered lines
		colorcolumn = "80", -- Indent line at what column? Set something like '99999' to not display it
		scrolloff = 5, -- Determines the number of context lines you would like to see above and below the cursor
		ignorecase = true, -- Ignore case in search
		smartcase = true, -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search.  timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
    smartindent = false
	}

	for k, v in pairs(custom_options) do
		vim.opt[k] = v
	end
end

init_custom_options()

-- vim.g.user_emmet_settings = {
--   indent_blockelement = 1,
--   user_emmet_leader_key = '<A-q>'
-- }

-- *
-- Key mappings
-- *
lvim.leader = "space"

lvim.keys.insert_mode = {
	-- Disable arrow keys
	[ "<Up>"] = "<NOP>",
	[ "<Down>"] = "<NOP>",
	[ "<Left>"] = "<NOP>",
	[ "<Right>"] = "<NOP>",

  ["<C-j>"] = "<esc>o",
  ["<C-k>"] = "<esc>O",
  ["<C-l>"] = "<CR><ESC>O",

  ["<A-p>"] = "<C-o>:IPythonCellInsertAbove<CR>",
  ["<A-n>"] = "<C-o>:IPythonCellInsertBelow<CR>",
}

lvim.keys.normal_mode = {
	-- Disable Ex mode, beause what the fuck is that...

  [ "Q"] = "<NOP>",
	-- Alternative way to save
	[ "<C-s>"] = ":w<CR>",

  -- Navigate IPython Cell
  ["[c"] = ":IPythonCellPrevCell<CR>",
  ["]c"] = ":IPythonCellNextCell<CR>",

  ["<A-p>"] = ":IPythonCellInsertAbove<CR>a",
  ["<A-n>"] = ":IPythonCellInsertBelow<CR>a",

	-- Better window movement
	["<C-h>"] = "<C-w>h",
	["<C-j>"] = "<C-w>j",
	["<C-k>"] = "<C-w>k",
	["<C-l>"] = "<C-w>l",

	-- Resize with arrows
	[ "<Up>"] = ":resize +2<CR>",
	[ "<Down>"] = ":resize -2<CR>",
	[ "<Left>"] = ":vertical resize -2<CR>" ,
	[ "<Right>"] = ":vertical resize +2<CR>" ,

	-- QuickFix
	["]q"] = ":cnext<CR>" ,
	["[q"] = ":cprev<CR>" ,
	["<C-q>"] = ":call QuickFixToggle()<CR>",

	-- LSP/Trouble
	["gR"] = "<cmd>Trouble lsp_references<CR>",

  -- Barbar.nvim
  ["`"] = ":BufferNext<CR>",
  ["~"] = ":BufferPrevious<CR>",
  ["<A-<>"] = ":BufferMovePrevious<CR>",
  ["<A->>"] = ":BufferMoveNext<CR>",

  ["<leader>1"] = ":BufferGoto 1<CR>",
  ["<leader>2"] = ":BufferGoto 2<CR>",
  ["<leader>3"] = ":BufferGoto 3<CR>",
  ["<leader>4"] = ":BufferGoto 4<CR>",
  ["<leader>5"] = ":BufferGoto 5<CR>",
  ["<leader>6"] = ":BufferGoto 6<CR>",
  ["<leader>7"] = ":BufferGoto 7<CR>",
  ["<leader>8"] = ":BufferGoto 8<CR>",
  ["<leader>9"] = ":BufferGoto 9<CR>",
  ["<leader>0"] = ":BufferGoto 0<CR>",

  ["<A-q>"] = ":BufferClose<CR>",
  ["<A-w>"] = ":BufferWipeout<CR>",
  ["<A-b>"] = ":BufferCloseAllButCurrent<CR>",
}

lvim.keys.term_mode = {
	-- Terminal window navigation
	[ "<C-h>"] = "<C-\\><C-N><C-w>h",
	[ "<C-j>"] = "<C-\\><C-N><C-w>j",
	[ "<C-k>"] = "<C-\\><C-N><C-w>k",
	[ "<C-l>"] = "<C-\\><C-N><C-w>l",
}
-- 
-- lvim.keys.visual_mode = {
-- 	-- Better indenting
-- 	["<"] = "<gv",
-- 	[">"] = ">gv",
-- 
-- 	-- Paste most recent yank
-- 	["p"] = '"0p', { silent = true },
-- 	["P"] = '"0P', { silent = true },
-- }

lvim.keys.visual_block_mode = {
	-- Move selected line / block of text in visual mode
	["K"] = ":move '<-2<CR>gv-gv",
	["J"] = ":move '>+1<CR>gv-gv",
}


-- *
-- Format
-- *
lvim.format_on_save = false

-- *
-- Linting
-- *
lvim.lint_on_save = true

-- *
-- Telescope
-- *
lvim.builtin.telescope.active = true
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git", "node_modules" }
local get_telescope_mappings = function()
	local actions = require("telescope.actions")
	return {
		i = {
			["<C-n>"] = actions.cycle_history_next,
			["<C-p>"] = actions.cycle_history_prev,
			["<C-c>"] = actions.close,
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			["<CR>"] = actions.select_default + actions.center,
			["<c-x>"] = false,
		},
		n = {
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
		},
	}
end

lvim.builtin.telescope.extensions = {
  fzf = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  },
}
lvim.builtin.telescope.on_config_done = function()
  require("telescope").load_extension "fzf"
end

lvim.builtin.telescope.defaults.mappings = get_telescope_mappings()

-- *
-- Dashboard
-- *
lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.custom_section.a.command = "Telescope find_files find_command=rg,--ignore,--hidden,--files"

-- *
-- Terminal
-- *
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shading_factor = 1

-- *
-- Nvimtree
-- *
-- currently revert back to commit dc630d199a0ad593036d193232c6b338aa0407e3
-- because of session-related bug
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.hide_dotfiles = 0

-- *
-- Treesitter
-- *
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.indent.enable = false
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.autotag.filetypes = { "html", "htmldjango", "xml"}

-- *
-- Whichkey
-- *
lvim.builtin.which_key.active = true
lvim.builtin.which_key.mappings["a"] = {
  name = "IPython",
  s = { "<cmd>SlimeSend1 ipython<CR>", "Start Ipython" },
  r = { "<cmd>IPythonCellRun<CR>", "Run file" },
  R = { "<cmd>IPythonCellRunTime<CR>", "Run file with time" },
  c = { "<cmd>IPythonCellExecuteCell<CR>", "Execute cell" },
  C = { "<cmd>IPythonCellExecuteCellJump<CR>", "Execute cell and jump" },
  l = { "<cmd>IPythonCellClear<CR>", "Clear cell" },
  q = { "<cmd>SlimeSend1 exit<CR>", "Exit IPython" },
  Q = { "<cmd>IPythonCellRestart<CR>", "Restart IPython" }
}
lvim.builtin.which_key.mappings["W"] = { "<cmd>w!<CR>", "Force Save" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>q!<CR>", "Force Quit" }
-- lvim.builtin.which_key.mappings["e"] = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" }
lvim.builtin.which_key.mappings["b"]["c"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer" }

lvim.builtin.which_key.mappings.o = { "<cmd>Vista<cr>", "Vista" }

lvim.builtin.which_key.mappings["s"]["f"] = {
	"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
	"Find File",
}
lvim.builtin.which_key.mappings["s"]["m"] = { "<cmd>Telescope marks<cr>", "Search Marks" }
lvim.builtin.which_key.mappings["s"]["g"] = { "<cmd>Telescope git_files<cr>", "Search Git Files" }

lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>SaveSession<cr>", "Save session" }
lvim.builtin.which_key.mappings["s"]["l"] = { "<cmd>RestoreSession<cr>", "Restore session" }
lvim.builtin.which_key.mappings["t"] = {
	name = "Toggle",
	h = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" },
	q = { "<cmd>call QuickFixToggle()<CR>", "Toggle Quick Fix List" },
	b = { "<cmd>GitBlameToggle<CR>", "Toggle Git Blame" },
	t = { "<cmd>Twilight<CR>", "Toggle Twilight" },
	i = { "<cmd>IndentBlanklineToggle<CR>", "Toggle Indent Line" },
}
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<CR>", "Zen Mode" }
lvim.builtin.which_key.mappings["x"] = {
	name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "Trouble Workspaces" },
	d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "Trouble Document" },
	l = { "<cmd>Trouble loclist<CR>", "Trouble Location List" },
	q = { "<cmd>Trouble quickfix<CR>", "Trouble Quickfix List" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}

-- *
-- LSP
-- *
-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- *
-- Lang
-- *
-- lvim.lang.go.formatter.exe = "goimports"

-- c/c++

lvim.lang.c.formatters = { { exe = "clang_format" } }
lvim.lang.cpp.formatters = lvim.lang.c.formatters

-- json
lvim.lang.json.formatters = {
  {
    exe = "prettier",
  },
}

-- python
lvim.lang.python.formatters = { { exe = "black" } }

lvim.lang.python.linters = { { exe = "flake8" } }

-- javascript
lvim.lang.javascript.formatters = { { exe = "prettier" } }
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters

lvim.lang.javascript.linters = { { exe = "eslint" } }
lvim.lang.javascriptreact.linters = lvim.lang.javascript.linters

-- typescript
lvim.lang.typescript.formatters = { { exe = "prettier" } }
lvim.lang.typescriptreact.formatters = lvim.lang.typescript.formatters

lvim.lang.typescript.linters = { { exe = "eslint" } }
lvim.lang.typescriptreact.linters = lvim.lang.typescript.linters

-- *
-- Additional Plugins
-- *

lvim.plugins = {
	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		setup = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("neoscroll").setup({
	-- 			-- All these keys will be mapped to their corresponding default scrolling animation
	-- 			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	-- 			hide_cursor = true, -- Hide cursor while scrolling
	-- 			stop_eof = true, -- Stop at <EOF> when scrolling downwards
	-- 			use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	-- 			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	-- 			cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
	-- 			easing_function = nil, -- Default easing function
	-- 		})
	-- 	end,
	-- },
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		event = "BufRead",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 1,
					height = 0.85, -- height of the Zen window
					options = {
						signcolumn = "no", -- disable signcolumn
						number = false, -- disable number column
						relativenumber = false, -- disable relative numbers
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					gitsigns = { enabled = false }, -- disables git signs
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "BufRead",
	},
	{
		"folke/twilight.nvim",
		event = "BufRead",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.25, -- amount of dimming
					-- we try to get the foreground from the highlight groups or fallback color
					color = { "Normal", "#ffffff" },
				},
				context = 20, -- amount of lines we will try to show around the current line
				-- treesitter is used to automatically expand the visible text,
				-- but you can further control the types of nodes that should always be fully expanded
				expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
					"function",
					"method",
					"table",
					"if_statement",
				},
				exclude = {}, -- exclude these filetypes
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        space_char_blankline = " ",
        filetype_exclude = { "dashboard", "Trouble", "NvimTree", "neogitstastus" },
        show_trailing_blankline_indent = false,
        buftype_exclude = { "help", "terminal", "nofile" },
      })

      vim.cmd("highlight IndentBlanklineChar guifg=#666B70 gui=nocombine")
    end
	},
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	config = function()
	-- 		require("github-theme").setup({
	-- 			themeStyle = "dimmed",
	-- 			commentStyle = "NONE",
	-- 			keywordStyle = "NONE",
	-- 			functionStyle = "NONE",
	-- 			variableStyle = "NONE",
	-- 			sidebars = { "qf", "vista_kind", "terminal", "packer" },
	-- 		})
	-- 		vim.cmd([[
	-- 		colorscheme "github-theme"
	-- 		]])
	-- 	end,
	-- },
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" },
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "lsp_document_diagnostics",
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- preview item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = true, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				use_lsp_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "rmagatti/auto-session",
    config = function ()
      -- lvim.autocommands.custom_groups = {
      --   "VimLeave", "*", "NvimTreeClose",
      -- }
      local opts = {
        log_level = 'info',
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        -- auto_session_enabled = true,
        auto_save_enabled = false,
        auto_restore_enabled = false,
        -- auto_session_suppress_dirs = nil,
        pre_save_cmds = {"NvimTreeClose"},
        -- post_restore_cmds = {"NvimTreeRefresh"}
      }

      require('auto-session').setup(opts)
      end
    },
    {
      "tamago324/lir.nvim",
      config = function()
        require "user.lir"
      end,
    },
    {
      "mattn/emmet-vim",
      setup = function ()

        vim.g.user_emmet_leader_key = '<c-y>'
        vim.g.user_emmet_settings = {
          indent_blockelement = 1,
        }
      end
    },
    -- {
    --   "nvim-telescope/telescope-fzy-native.nvim",
    --   run = "make",
    --   event = "BufRead",
    -- },
   { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("user.lsp_signature").config()
      end,
    },
    {
      "windwp/nvim-spectre",
      event = "BufRead",
      config = function()
        require("user.spectre").config()
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      config = function ()
        -- require('nvim-ts-autotag').setup({
        --   -- currently disable for htmldjango due to incompatible
        --   filetypes = { "html" , "xml" },
        -- })
      end,
      ft = { 'html', 'htmldjango', 'xml' }
    },
    {
      "liuchengxu/vista.vim"
    },
    {
      "jpalardy/vim-slime",
      ft = 'python',
      config = function ()
        require("user.vim_slime").config()
      end
    },
    {
      "hanschen/vim-ipython-cell",
      ft = 'python'
    },
    {
      "mg979/vim-visual-multi"
    },
    -- {
    --   "sotte/presenting.vim"
    -- },
    -- {
    --   "vim-pandoc/vim-pandoc",
    --   config = function ()
    --       -- vim.g.pandoc[filetypes]
    --   end
    -- }
    -- {
    --   "tweekmonster/django-plus.vim",
    -- }
  }

  -- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
