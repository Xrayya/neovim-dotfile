# Neovim Dotfiles

![Lua](https://img.shields.io/badge/Lua-100%25-blue.svg)
![Neovim](https://img.shields.io/badge/Neovim-Config-critical.svg)

My personal Neovim configuration — built with **modularity**, **lightweight design**, and a **plug-and-play mindset** in mind.

---

## 🚀 Installation

1. Clone this repository into your [`$XDG_CONFIG_HOME`](https://neovim.io/doc/user/starting.html#%24XDG_CONFIG_HOME), for example on Linux:

   ```bash
   git clone https://github.com/Xrayya/neovim-dotfile.git ~/.config/nvim

   ```

2. Open Neovim and let it automatically install all required dependencies and also create `lua/extra-cofig/init.lua` file

3. You might want to update the all the plugins with `:Lazy sync` since I keep `lazy-lock.json` tracked and might out of date. You might also want to remove the lockfile altogether, it's your choice. I keep the `lazy-lock.json` because I need it.

4. Enable predefined plugins by importing the appropriate files into `lua/extra-config/init.lua`

That’s it.

---

## ⚙️ Usage

After installation, you’ll immediately get a fully working setup:
keymaps, options, and a set of carefully chosen [core plugins](#-core-plugins) are enabled by default.

This repository also provides a collection of predefined **essential plugins** and **extra (optional) plugins** that you can enable as needed — true plug-and-play.

For your own customization, `extra-config/init.lua` is the intended entry point.
Use it to define personal tweaks or load additional configurations that are not included by default.
This file is gitignore'd by default since the philosophy is to make this whole Neovim configuration modular, plug and play,
and can be ajdusted for multiple purposes in pultiple environment. Well, at least I always keep that mindset in mind when I develop this repository.

You can explore existing modules under:

- [`lua/xrayya/essentials`](https://github.com/Xrayya/neovim-dotfile/tree/main/lua/xrayya/essentials)
- [`lua/xrayya/extras`](https://github.com/Xrayya/neovim-dotfile/tree/main/lua/xrayya/extras)

Feel free to import, extend, or organize them into your own subfolders.
Or, if you prefer, fork this repository and shape it entirely to your liking.

---

## 📦 Plugins

Below is an overview of the plugins used in this setup.

### 🔑 Core Plugins

The foundation of the configuration: editor options, keymaps, and the most critical plugins. Core plugins include:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)
- [mason.nvim](https://github.com/mason-org/mason.nvim) with [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) and [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim)
- [lazydev.nvim](https://github.com/folke/lazydev.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) with [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim), [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim), and [telescope-all-recent.nvim](https://github.com/prochri/telescope-all-recent.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), etc.

---

### 🎒 Essential Plugins

Quality-of-life improvements such as statusline, snippets, and Git integration.
Some highlights:

- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (customized, see [here](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/essentials/statusline/init.lua))
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), with:
  - [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects), and more
  - [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) with [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim), [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view), and [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
- [overseer.nvim](https://github.com/stevearc/overseer.nvim)

---

### 🧩 Extra (Optional) Plugins for Specific Needs

Additional features such as Discord presence, AI integrations, and language-specific tooling.
This section is still growing.

Some notable extras:

- **Language packs**:
  - JavaScript / TypeScript (js, ts, jsx, tsx)
    - Using [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim)
      ([config](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/js-ts-typescript-tools.lua))
    - Or plain [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
      ([config](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/js-ts.lua))
  - [Lua](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/lua.lua)
  - [JSON](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/json.lua) and [YAML](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/yaml.lua), with [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) configured
  - [Java](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/java-java.lua) using [nvim-java](https://github.com/nvim-java/nvim-java) which makes all necessary tools already set up and ready to go.
- Discord presence via [cord.nvim](https://github.com/vyfor/cord.nvim)
- Symbols outline using [aerial.nvim](https://github.com/stevearc/aerial.nvim), etc.
- Debugger setup for [JavaScript, TypeScript, Chrome, and MSEdge](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/debugger/js-chrome-msedge.lua) using [vscode-js-debug](https://github.com/microsoft/vscode-js-debug) already configured and works

---

## ✨ Preview

A quick look at how this Neovim setup feels in daily use.

### Editing Experience

Clean syntax highlighting, LSP diagnostics, and completion out of the box.

![Editing](https://github.com/user-attachments/assets/4c7f3fc2-0920-49e7-9a13-ade4c74294f4)

### Navigation & Search

Fast project-wide navigation powered by Telescope.

![Telescope](https://github.com/user-attachments/assets/6dbf940d-3833-4c3c-9ade-72ecadc519de)

### Git Integration

Inline Git signs and context-aware diffs for real-world workflows.

![Git](https://github.com/user-attachments/assets/d86f9dfa-4dda-4023-974e-f411b9e3e12f)

### Running Debugger

Running Chrome Debugger in React Project and stop on breakpoint

![Running Chrome Debugger in React Project](https://github.com/user-attachments/assets/e7c810c5-724a-4e29-9e4a-dec65e0176e3)

### Optional Extras

Additional UI enhancements and tools you can opt into.

![Extras](https://github.com/user-attachments/assets/80e31d89-69ab-4bd4-b012-81977c86ba65)

---

## 🎨 My Preferences, My Taste

This is my **personal** Neovim configuration, designed primarily for how I work and think.

That said, the structure is intentionally kept flexible so it can adapt to different workflows and use cases.
Some choices may reflect my personal preferences and might not align with everyone’s taste — and that’s okay.

It’s open source.
Tweak it, bend it, or completely reshape it into something that feels right for you.

For reference, here is my current `lua/extra-config/init.lua`:

```lua
---@module "lazy"
---@type LazySpec
return {
  { import = "xrayya.essentials" },
  { import = "xrayya.essentials.treesitter" },
  { import = "xrayya.extras.ui.alpha" },
  { import = "xrayya.extras.ui.smear-cursor" },
  { import = "xrayya.extras.aerial" },
  { import = "xrayya.extras.colorizer" },
  { import = "xrayya.extras.todo-comment" },
  { import = "xrayya.extras.external" },
  { import = "xrayya.extras.lazygit" },
  { import = "xrayya.extras.tmux" },
  { import = "xrayya.extras.ui.undo-glow" },
  { import = "xrayya.extras.markdown-preview" },

  { import = "xrayya.extras.langs.lua" },
  { import = "xrayya.extras.langs.html-css" },
  { import = "xrayya.extras.langs.tailwindcss" },
  { import = "xrayya.extras.langs.js-ts-typescript-tools" },
  { import = "xrayya.extras.langs.json" },
  { import = "xrayya.extras.langs.yaml" },
  { import = "xrayya.extras.langs.c-cpp" },
  { import = "xrayya.extras.langs.java-java" },
  { import = "xrayya.extras.langs.python" },
  { import = "xrayya.extras.langs.xml" },
  { import = "xrayya.extras.langs.git" },
  { import = "xrayya.extras.langs.bash" },
  { import = "xrayya.extras.langs.ini" },
  { import = "xrayya.extras.langs.kitty" },
  { import = "xrayya.extras.langs.udev" },

  { import = "xrayya.extras.formatter.stylua" },
  { import = "xrayya.extras.formatter.prettier" },

  {import = "xrayya.extras.debugger.js-chrome-msedge"}
}
```

---

## 🛠 Contributing

Found something that could be improved?
Feel free to open an Issue or submit a Pull Request — contributions are always welcome.

---

> Made with ❤️ by [Xrayya](https://github.com/Xrayya)
