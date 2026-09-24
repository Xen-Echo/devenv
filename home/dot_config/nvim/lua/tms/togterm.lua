-- Very basic terminal buffer manager with toggling and renaming functionality
--   Usage:
--   -- :TMSTogTerm <name>              - Toggle terminal with given name
--   -- :TMSTogTermRename               - Rename the current terminal buffer
--   -- :TMSTogTermSendLineToScratch    - Send the current line to the "Scratch" terminal (creates it if it doesn't exist)

local M = {}

local terminals = {}

local function t_name(name)
    return "Terminal: " .. name
end

local function rename_terminal(buf, new_name)
    if buf then
        local old_name = nil
        local new_name_in_use = false

        -- Find the old name and check if the new name is already in use
        for name, b in pairs(terminals) do
            if b == buf then
                old_name = name
            end
            if name == new_name then
                new_name_in_use = true
            end
        end

        if not old_name then
            print("Current buffer is not a managed terminal")
            return
        end

        if new_name_in_use then
            print("Terminal name already in use")
            return
        end

        -- Rename the terminal
        terminals[new_name] = buf
        terminals[old_name] = nil
        vim.api.nvim_buf_set_name(buf, t_name(new_name))
    else
        print("No terminal buffer to rename")
    end
end

local function show_terminal_buffer(buf, name, initialise)
    if buf then
        vim.cmd("belowright split")
        vim.cmd("buffer " .. buf)
        if initialise then
            vim.cmd("terminal")
            vim.cmd("hide")
            return
        end
        vim.cmd("resize 10")
        if name then
            vim.api.nvim_buf_set_name(buf, t_name(name))
        end
        vim.cmd("startinsert")
    end
end

local function create_terminal_buffer()
    local buf = vim.api.nvim_create_buf(false, true)
    show_terminal_buffer(buf, nil, true)
    return buf
end

local function create_and_show_terminal(name)
    local buf = create_terminal_buffer()
    terminals[name] = buf
    show_terminal_buffer(buf, name)
end

local function toggle_terminal(name)
    local current_buf = vim.api.nvim_get_current_buf()
    local is_managed_terminal = false

    for _, buf in pairs(terminals) do
        if buf == current_buf then
            is_managed_terminal = true
            break
        end
    end

    -- If we are currently toggling a managed terminal, just hide it
    if is_managed_terminal then
        vim.cmd("hide")
        return
    end

    local buf = terminals[name]

    -- If the terminal with the given name does not exist or is invalid, create it
    if not buf or not vim.api.nvim_buf_is_valid(buf) then
        create_and_show_terminal(name)
    else
        show_terminal_buffer(buf, name, false)
    end

    return buf
end

-- Setup function to create user commands for the terminal manager
M.setup = function()
    vim.api.nvim_create_user_command('TMSTogTerm', function(opts)
        toggle_terminal(opts.args)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command('TMSTogTermRename', function()
        -- Request a new name and rename the current terminal
        local new_name = vim.fn.input("New Terminal Name: ")
        rename_terminal(vim.api.nvim_get_current_buf(), new_name)
    end, { nargs = 0 })

    vim.api.nvim_create_user_command('TMSTogTermSendLineToScratch', function()
        -- Send the current line to the Scratch terminal
        local line = vim.api.nvim_get_current_line()
        local scratch_terminal = "tms://scratch"
        local buf = terminals[scratch_terminal]
        if buf and vim.api.nvim_buf_is_valid(buf) then
            local buf_info = vim.fn.getbufinfo(buf)[1]
            if buf_info.hidden == 0 then
                -- We can't directly send to the exiting visible buffer so, swap the current buffer, send the line, and swap back
                local current_buf = vim.api.nvim_get_current_buf()
                vim.cmd("buffer " .. buf)
                vim.api.nvim_chan_send(vim.b.terminal_job_id, line .. "\n")
                vim.cmd("buffer " .. current_buf)
                return
            end
        end
        toggle_terminal(scratch_terminal)
        vim.api.nvim_chan_send(vim.b.terminal_job_id, line .. "\n")
    end, { nargs = 0 })
end

return M
