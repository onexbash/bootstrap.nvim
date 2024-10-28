-- -- -- -- -- -- -- -- -- -- --
-- -- -- BOOTSTRAP.NVIM -- -- --
--    github.com/onexbash     --
-- -- -- -- -- -- -- -- -- -- --
-- neovim plugin for lua code --
-- that needs to be loaded    --
-- before every other plugin  --
-- -- -- -- -- -- -- -- -- -- --
-- -- --     USAGE      -- -- --
--

local M = {}

M.prerequisites = {
	{ name = "nvim", bin = "nvim", version = "latest", github_short_url = "neovim/neovim" },
	{ name = "vim", bin = "vim", version = "latest", github_short_url = "vim/vim" },
	{ name = "git", bin = "git", version = "2.4.7", github_short_url = "git/git" },
	{ name = "fzf", bin = "fzf", version = "latest", github_short_url = "junegunn/fzf" },
	{ name = "fd", bin = "fd", version = "latest", github_short_url = "sharkdp/fd" },
	{ name = "yay", bin = "yay", version = "latest", github_short_url = "yay/yay" },
}

local function is_executable(bin)
	local shell = os.getenv("SHELL") or "/bin/sh"
	local handle = io.popen(shell .. " -c 'command -v " .. bin .. "'")
	local result = handle:read("*a")
	handle:close()
	return result and result ~= ""
end

function M.show()
	for _, prereq in ipairs(M.prerequisites) do
		if is_executable(prereq.bin) then
			vim.notify("󱁖 " .. prereq.name .. " is installed", vim.log.levels.INFO)
		else
			vim.notify("✗ " .. prereq.name .. " is NOT installed", vim.log.levels.ERROR)
		end
	end
end

-- Create the :1bootstrap command
vim.api.nvim_create_user_command("bootstrap", function()
	M.show()
end, {})

-- Setup function to integrate with lazy.nvim opts
function M.setup(opts)
	-- Use opts to customize your plugin's behavior if necessary
	M.options = opts or {}
	-- Call the show function on setup if required
	if M.options.show_on_setup then
		M.show()
	end
end

return M
