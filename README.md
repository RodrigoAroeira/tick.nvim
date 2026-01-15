
# tick.nvim

Neovim plugin for running [tick](https://github.com/RodrigoAroeira/tick) inside Neovim.

`tick.nvim` opens `tick` in a floating terminal window and fully locks terminal mode so all input is forwarded directly to `tick`.

---

## Requirements

* Neovim >= 0.8.0
* `tick` executable available in `$PATH`

---

## Installation

Using [`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
return {
  "RodrigoAroeira/tick.nvim",
  -- Optional: automatically install tick
  -- build = "cargo install --git https://github.com/RodrigoAroeira/tick",
}
```

> Installing `tick` is optional and left to the user.
> The plugin assumes the `tick` binary is available in `$PATH`.

---

## Usage

```vim
:Tick
```

Open `tick` in a floating window using the default path (`~/TODO`).

```vim
:Tick {path}
```

Open `tick` at a specific path.

### Examples

```vim
:Tick .
:Tick ~/notes
```

---

## Keymaps

By default, the plugin defines the following mappings:

* `<leader>Tg` — Open `tick` at the global default path
* `<leader>Th` — Open `tick` in the current working directory

---

## Notes

* `<Esc>` is forwarded directly to `tick`
* Terminal-mode escape sequences are disabled while `tick` is running
* The window automatically resizes on `VimResized`

