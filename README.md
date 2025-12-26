# Neovim Dotfiles

![Lua](https://img.shields.io/badge/Lua-100%25-blue.svg)
![Neovim](https://img.shields.io/badge/Neovim-Config-critical.svg)

My personal Neovim configuration — built with **modularity**, **lightweight design**, and a **plug-and-play mindset** in mind.

---

## 🚀 Installation

1. Clone this repository into your [`stdpath("config")`](<https://neovim.io/doc/user/builtin.html#stdpath()>), for example on Linux:

   ```bash
   git clone https://github.com/Xrayya/neovim-dotfile.git ~/.config/nvim

   ```

2. Open Neovim and let it automatically install all required dependencies.

3. You might want to update the all the plugins with `:Lazy sync` since I keep `lazy-lock.json` tracked and might out of date. You might also want to remove the lockfile altogether, it's your choice. I keep the `lazy-lock.json` because I need it.

That’s it.

---

## ⚙️ Usage

After installation, you’ll immediately get a fully working setup:
keymaps, options, and a set of carefully chosen [core plugins](#-core-plugins) are enabled by default.

This repository also provides a collection of predefined **essential plugins** and **extra (optional) plugins** that you can enable as needed — true plug-and-play.

For your own customization, `extra-config/init.lua` is the intended entry point.
Use it to define personal tweaks or load additional configurations that are not included by default.

You can explore existing modules under:

- [`lua/xrayya/essentials`](https://github.com/Xrayya/neovim-dotfile/tree/main/lua/xrayya/essentials)
- [`lua/xrayya/extras`](https://github.com/Xrayya/neovim-dotfile/tree/main/lua/xrayya/extras)

Feel free to import, extend, or organize them into your own subfolders.
Or, if you prefer, fork this repository and shape it entirely to your liking.

---

## 📦 Plugins

Below is an overview of the plugins used in this setup.

### 🔑 Core Plugins

The foundation of the configuration: editor options, keymaps, and the most critical plugins.
Some notable ones:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), etc.

---

### 🎒 Essential Plugins

Quality-of-life improvements such as statusline, snippets, and Git integration.
Some highlights:

- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (customized, see [here](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/essentials/statusline/init.lua))
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), with:
  - [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim), etc.

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
  - [JSON](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/json.lua) and
    [YAML](https://github.com/Xrayya/neovim-dotfile/blob/main/lua/xrayya/extras/langs/yaml.lua), with
    [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) configured
- Discord presence via [cord.nvim](https://github.com/vyfor/cord.nvim)
- Symbols outline using [aerial.nvim](https://github.com/stevearc/aerial.nvim), etc.

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

---

## 🛠 Contributing

Found something that could be improved?
Feel free to open an Issue or submit a Pull Request — contributions are always welcome.

---

> Made with ❤️ by [Xrayya](https://github.com/Xrayya)
