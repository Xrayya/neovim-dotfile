---@module "lazy"
---@type LazySpec

local token_cache = { token = nil, expires_at = 0 }

---Retrieve and cache Google Cloud OAuth access token for 50 minutes.
---Prevents running `gcloud` subprocess on every autocomplete keystroke.
---@return string
local function get_cached_gcloud_token()
  local now = os.time()
  if token_cache.token and now < token_cache.expires_at then
    return token_cache.token
  end

  local token = vim.fn.system("gcloud auth print-access-token"):gsub("%s+", "")
  if vim.v.shell_error == 0 and #token > 0 then
    token_cache.token = token
    token_cache.expires_at = now + 3000 -- Cache for 50 minutes (Google tokens expire in 60m)
    return token
  end

  return token_cache.token or ""
end

-- GCP settings matching codecompanion.lua
local project_id = "valid_id"
local region = "global"

local endpoint = region == "global"
    and string.format(
      "https://aiplatform.googleapis.com/v1/projects/%s/locations/global/endpoints/openapi/chat/completions",
      project_id
    )
  or string.format(
    "https://%s-aiplatform.googleapis.com/v1/projects/%s/locations/%s/endpoints/openapi/chat/completions",
    region,
    project_id,
    region
  )

return {
  {
    "milanglacier/minuet-ai.nvim",
    -- To load from your local cloned repository instead of remote github, uncomment:
    -- dir = vim.fn.expand("~/WindowsD/my-programming-project/Repos/minuet-ai.nvim"),
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      -- Manual trigger keymaps for ghost text completion in insert mode
      vim.keymap.set("i", "<A-y>", function()
        require("minuet.virtualtext").action.next()
      end, { desc = "Minuet AI: Manually trigger completion", silent = true })

      vim.keymap.set("i", "<M-\\>", function()
        require("minuet.virtualtext").action.next()
      end, { desc = "Minuet AI: Manually trigger completion (Copilot style)", silent = true })
    end,
    opts = {
      provider = "openai_compatible",
      request_timeout = 6,
      throttle = 1000,
      debounce = 400,
      notify = "warn",
      virtualtext = {
        -- Empty table disables automatic triggering on typing.
        -- Ghost text completion will only be fetched when manually triggered (<A-y> or <M-\>).
        auto_trigger_ft = {},
        auto_trigger_ignore_ft = {},
        keymap = {
          accept = "<C-S-Y>", -- Accept whole completion (matching Copilot habit)
          accept_line = "<C-Y>", -- Accept single line
          accept_n_lines = "<A-z>", -- Accept n lines
          prev = "<A-[>", -- Previous suggestion
          next = "<A-]>", -- Next suggestion (or trigger if none)
          dismiss = "<A-e>", -- Dismiss suggestion
        },
      },
      provider_options = {
        openai_compatible = {
          model = "google/gemini-2.5-flash",
          name = "VertexAI",
          end_point = endpoint,
          api_key = get_cached_gcloud_token,
          stream = true,
          optional = {
            max_tokens = 512,
          },
        },
      },
    },
  },
}
