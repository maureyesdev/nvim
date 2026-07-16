# sqls Per-Project Database Configuration

`sqls` (SQL language server) supports schema-aware completions — table names, column names, etc. — but it needs to know which database to connect to. The cleanest approach is to configure it per-project so suggestions never bleed across databases.

## How it works

Neovim loads a `.nvim.lua` file from the project root automatically (requires `exrc = true` in opts). That file overrides the `sqls` LSP settings for that project only, pointing it at the right database.

## Setup

### 1. Enable exrc in your opts

```lua
vim.o.exrc = true
```

### 2. Add a `.nvim.lua` to each project root

**`~/projects/recipes/.nvim.lua`**
```lua
vim.lsp.config("sqls", {
  settings = {
    sqls = {
      connections = {
        {
          alias = "recipes",
          driver = "postgresql",
          dataSourceName = "host=localhost port=5432 user=postgres password=secret dbname=recipes sslmode=disable",
        },
      },
    },
  },
})
```

**`~/projects/online-store/.nvim.lua`**
```lua
vim.lsp.config("sqls", {
  settings = {
    sqls = {
      connections = {
        {
          alias = "online-store",
          driver = "postgresql",
          dataSourceName = "host=localhost port=5432 user=postgres password=secret dbname=online_store sslmode=disable",
        },
      },
    },
  },
})
```

### 3. Add `.nvim.lua` to your global gitignore

Connection strings contain credentials and should never be committed.

```bash
echo ".nvim.lua" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```

## Supported drivers

| Driver       | dataSourceName format                                          |
|--------------|----------------------------------------------------------------|
| `postgresql` | `host=localhost port=5432 user=u password=p dbname=db sslmode=disable` |
| `mysql`      | `user:password@tcp(localhost:3306)/dbname`                     |
| `sqlite3`    | `/path/to/database.db`                                         |

## Switching connections manually

If you have multiple connections configured, you can switch between them inside Neovim:

```
:SqlsSwitchConnection
```
