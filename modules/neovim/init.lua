-- TODO: https://github.com/ribru17/bamboo.nvim
-- https://github.com/topics/neovim-colorscheme
--
-- TODO: comment folding
-- TODO: goto tree (if thats possible)
-- TODO: set as default editor
-- TODO: cursor should go to the last character using w on the last word, rather than jumping to the next line
-- TODO: maybe configure snake and camel case as words
-- TODO: make buffer move up/down with the cursor sooner than it normally does
-- TODO: hover nvim tree should preview file

-- globals
do
	vim.g.mapleader = " "
	vim.g.zig_fmt_autosave = 0
end

-- options
do
	vim.opt.autoindent = true
	vim.opt.colorcolumn = { 80, 120 }
	vim.opt.expandtab = false
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
	vim.opt.laststatus = 3
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.shiftwidth = 4
	vim.opt.showmode = false
	vim.opt.smartindent = true
	vim.opt.tabstop = 4
	vim.opt.termguicolors = true
	vim.opt.wrap = false
end

-- theme config
do
	local bamboo = require("bamboo")
	local catppuccin = require("catppuccin")
	local vscode = require("vscode")

	bamboo.setup()
	bamboo.load()
end

-- keybinds
do
    local keybinds = {
        {
            mode = "n",
            key = "<leader>b",
            action = "<cmd>Telescope buffers<cr>",
            options = { desc = "List open buffers using Telescope.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>f",
            action = "<cmd>Telescope find_files<cr>",
            options = { desc = "List files using Telescope.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>g",
            action = "<cmd>Telescope live_grep<cr>",
            options = { desc = "Live grep files using Telescope.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>q",
            action = "<CMD>bd<CR>",
            options = { desc = "Deletes the current buffer.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>h",
            action = "<CMD>lua vim.lsp.buf.hover()<CR>",
            options = { desc = "Displays information about symbol under cursor.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>d",
            action = "<CMD>lua vim.lsp.buf.definition()<CR>",
            options = { desc = "Goes to definition of symbol under cursor.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>a",
            action = "<CMD>lua vim.lsp.buf.code_action()<CR>",
            options = { desc = "Lists possible code actions under cursor.", silent = true },
        },
        {
            mode = "n",
            key = "<leader><tab>",
            action = "<CMD>NvimTreeToggle<CR>",
            options = { desc = "Toggles the directory tree.", silent = true },
        },
        {
            mode = "n",
            key = "<leader>i",
            action = "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
            options = { desc = "Toggles inlay hints.", silent = true },
        },
    }

    for _, keybind in ipairs(keybinds) do
        vim.keymap.set(keybind.mode, keybind.key, keybind.action, keybind.options)
    end
end

-- autocommands
do
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function(data)
			-- buffer is a directory
			local directory = vim.fn.isdirectory(data.file) == 1

			-- buffer is a [No Name]
			local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

			-- Will automatically open the tree when running setup if startup buffer is a directory,
			-- is empty or is unnamed. nvim-tree window will be focused.
			local open_on_setup = true

			if (directory or no_name) and open_on_setup then
				-- change to the directory
				if directory then
					vim.cmd.cd(data.file)
				end

				-- open the tree
				require("nvim-tree.api").tree.open()
				return
			end

			------------------------------------------------------------------------------------------

			-- Will automatically open the tree when running setup if startup buffer is a file.
			-- File window will be focused.
			-- File will be found if updateFocusedFile is enabled.
			local open_on_setup_file = false

			-- buffer is a real file on the disk
			local real_file = vim.fn.filereadable(data.file) == 1

			if (real_file or no_name) and open_on_setup_file then
				-- skip ignored filetypes
				local filetype = vim.bo[data.buf].ft
				local ignored_filetypes = {}

				if not vim.tbl_contains(ignored_filetypes, filetype) then
					-- open the tree but don't focus it
					require("nvim-tree.api").tree.toggle({ focus = false })
					return
				end
			end

			------------------------------------------------------------------------------------------

			-- Will ignore the buffer, when deciding to open the tree on setup.
			local ignore_buffer_on_setup = false
			if ignore_buffer_on_setup then
				require("nvim-tree.api").tree.open()
			end
		end
	})

	vim.api.nvim_create_autocmd("CursorMoved", {
		group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
		callback = function()
			if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
				vim.schedule(function()
					vim.cmd.nohlsearch()
				end)
			end
		end,
	})
end

-- other random required plugins
require("nvim-web-devicons").setup({})
require("treesitter-context").setup({ max_lines = 1 })

-- lsp
do
	-- Nixvim's internal module table
	-- Can be used to share code throughout init.lua
	local _M = {}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    local __lspServers = {
        { name = "zls" },
        { name = "taplo" },
        { name = "rust_analyzer" },
        { name = "pyright" },
        { name = "nixd" },
        { name = "lua_ls" },
        { name = "cssls" },
        { name = "clangd" },
    }

    -- Adding lspOnAttach function to nixvim module lua table so other plugins can hook into it.
    _M.lspOnAttach = function(client, bufnr)
        -- LSP Inlay Hints
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end
    local __lspCapabilities = function()
        capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- Capabilities configuration for nvim-ufo
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        return capabilities
    end

    local __setup = {
        on_attach = _M.lspOnAttach,
        capabilities = __lspCapabilities(),
    }

    for i, server in ipairs(__lspServers) do
        if type(server) == "string" then
            require("lspconfig")[server].setup(__setup)
        else
            local options = server.extraOptions

            if options == nil then
                options = __setup
            else
                options = vim.tbl_extend("keep", options, __setup)
            end

            require("lspconfig")[server.name].setup(options)
        end
    end
end

-- completions
do
	local cmp = require("cmp")
	cmp.setup({
		window = {
			completion = cmp.config.window.bordered({ border = "single" }),
			documentation = cmp.config.window.bordered({ border = "single" }),
		},
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping.confirm({ select = true })
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" }
		},
	})
end

-- installs treesitter parsers at runtime.
-- is there any way to use nixpkgs instead?
do
	vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
	require("nvim-treesitter.configs").setup({
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
		sync_install = true,
	})
end

require("telescope").setup({
    defaults = {
        border = {
			preview = { 1, 1, 1, 1 },
			prompt = { 1, 1, 1, 1 },
			results = { 1, 1, 1, 1 }
		},
        borderchars = {
            preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
            prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
            results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
        },
    },
})

require("ufo").setup({})

require("nvim-autopairs").setup({})

require("lualine").setup({
    options = {
        component_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = { statusline = 1 },
        section_separators = { left = "", right = "" },
        theme = "auto",
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(ident)
                    local map = {
                        ["NORMAL"] = "NOR",
                        ["INSERT"] = "INS",
                        ["VISUAL"] = "VIS",
                        ["V-LINE"] = "V-L",
                        ["V-BLOCK"] = "V-B",
                        ["REPLACE"] = "REP",
                        ["COMMAND"] = "CMD",
                        ["TERMINAL"] = "TERM",
                        ["EX"] = "EX",
                        ["SELECT"] = "SEL",
                        ["S-LINE"] = "S-L",
                        ["S-BLOCK"] = "S-B",
                        ["OPERATOR"] = "OPR",
                        ["MORE"] = "MORE",
                        ["CONFIRM"] = "CONF",
                        ["SHELL"] = "SH",
                        ["MULTICHAR"] = "MCHR",
                        ["PROMPT"] = "PRMT",
                        ["BLOCK"] = "BLK",
                        ["FUNCTION"] = "FUNC",
                    }
                    return map[ident] or ident
                end,
            },
        },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "fileformat" },
        lualine_z = { "location" },
    },
})

require("ibl").setup({
	indent = { char = "│" },
	scope = { enabled = false }
})

require("gitsigns").setup({})

require("crates").setup({})

require("nvim-tree").setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_directories = { auto_open = true, enable = true },
    hijack_netrw = true,
})

