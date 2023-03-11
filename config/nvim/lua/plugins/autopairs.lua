---------------------------------------------------------------------------------
---@author Real Ferhat (@real-fht) <nferhat20@gmail.com>
---@copyright 2022-2023 Real Ferhat (@real-fht) <nferhat20@gmail.com>

---------------------------------------------------------------------------------

local M = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
}

M.config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
        disable_in_filetype = "TelescopePrompt",
        disable_in_macro = true,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = nil, -- always  do autopairs.
        enable_moveright = true,
        enable_afterquote = true,
        enable_abbr = true,
        enable_undo = true,
        check_ts = true,
        map_cr = true,
        map_bs = true,
        map_c_w = true,
    })

    -- Custom rule to add spaces between pairs.
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
    autopairs.add_rules({
        Rule(" ", " ")
            :with_pair(function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                return vim.tbl_contains({
                    brackets[1][1] .. brackets[1][2],
                    brackets[2][1] .. brackets[2][2],
                    brackets[3][1] .. brackets[3][2],
                }, pair)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - 1, col + 2)
                return vim.tbl_contains({
                    brackets[1][1] .. "  " .. brackets[1][2],
                    brackets[2][1] .. "  " .. brackets[2][2],
                    brackets[3][1] .. "  " .. brackets[3][2],
                }, context)
            end),
    })
    for _, bracket in pairs(brackets) do
        Rule("", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts)
                return opts.char == bracket[2]
            end)
            :with_cr(cond.none())
            :with_del(cond.none())
            :use_key(bracket[2])
    end

    -- Move past comas and semicolons.
    for _, punct in pairs({ ",", ";" }) do
        autopairs.add_rules({
            Rule("", punct)
                :with_move(function(opts)
                    return opts.char == punct
                end)
                :with_pair(function()
                    return false
                end)
                :with_del(function()
                    return false
                end)
                :with_cr(function()
                    return false
                end)
                :use_key(punct),
        })
    end
end

return M
