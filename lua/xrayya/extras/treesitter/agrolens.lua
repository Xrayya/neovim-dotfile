---@module "lazy"
---@type LazySpec
return {
  "desdic/agrolens.nvim",
  config = function(_, opts)
    local is_ok_fzf, FzfLua = pcall(require, "fzf-lua")
    if is_ok_fzf then
      --- NOTE: Gemini generated
      vim.api.nvim_create_user_command("Agrolens", function(fOpts)
        -- 1. Establish defaults based on your parameter specifications
        local args = {
          query = "functions,callings,comments,labels",
          buffers = "all",
          same_type = true, -- Defaults to true per your specification
          disable_indentation = false,
          include_hidden_buffers = false,
          -- aliases and match default to nil/empty if not provided
        }

        -- 2. Parse the space-separated key=value arguments
        -- opts.fargs splits ["query=functions", "same_type=false"]
        for _, arg in ipairs(fOpts.fargs) do
          local key, value = arg:match("([^=]+)=(.*)")

          if key and value then
            -- Normalize common alias slip-ups
            if key == "buffer" then
              key = "buffers"
            end
            if key == "includehiddenbuffers" then
              key = "include_hidden_buffers"
            end

            -- Convert string booleans to raw Lua booleans
            if value == "true" then
              value = true
            elseif value == "false" then
              value = false
            end

            args[key] = value
          end
        end

        -- 3. Execute the function call with the fully built arguments table
        require("agrolens.fzf").run(args)
      end, {
        nargs = "*", -- Allows zero or more arguments, using defaults if empty
        complete = function(ArgLead, _, _)
          local candidates = {
            "query",
            "buffers",
            "same_type",
            "disable_indentation",
            "include_hidden_buffers",
          }
          local matches = {}

          -- Filter the list for candidates that start with what the user typed (ArgLead)
          for _, candidate in ipairs(candidates) do
            if vim.startswith(candidate, ArgLead) then
              table.insert(matches, candidate)
            end
          end

          return matches
        end,
      })
    end

    local is_ok_telescope, telescope = pcall(require, "telescope")
    if not is_ok_fzf and is_ok_telescope then
      telescope.load_extension("agrolens")

      telescope.extensions = {
        agrolens = opts,
      }
    end
  end,
}
