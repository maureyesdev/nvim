return {
  -----------------------------------------------------------------------------
  -- Syntax highlight
  -----------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "scss", "typescript" })
    end,
  },

  -----------------------------------------------------------------------------
  -- Formatting
  -----------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft =
        vim.tbl_deep_extend("force", opts.formatters_by_ft, {
          html = { "prettier" },
          scss = { "prettier" },
          typescript = { "prettier" },
        })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP installation
  -----------------------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettier" })
      -- we intentionally skip "angular-language-server" here to use local project version
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP config
  -----------------------------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local util = require("lspconfig.util")

      local function get_probe_dir(root_dir)
        local project_root = vim.fs.dirname(
          vim.fs.find("node_modules", { path = root_dir, upward = true })[1]
        )
        return project_root and (project_root .. "/node_modules") or ""
      end

      local function get_package_json_path(root_dir)
        local node_modules_path = get_probe_dir(root_dir)
        if node_modules_path == "" then
          return nil
        end
        return vim.fs.dirname(node_modules_path) .. "/package.json"
      end

      local function get_angular_core_version(root_dir)
        local package_json_path = get_package_json_path(root_dir)
        if not package_json_path or not vim.uv.fs_stat(package_json_path) then
          return nil
        end

        local file = io.open(package_json_path, "r")
        if not file then
          return nil
        end

        local contents = file:read("*a")
        file:close()

        local ok, json = pcall(vim.json.decode, contents)
        if not ok then
          return nil
        end

        local version = (
          json.dependencies and json.dependencies["@angular/core"]
        )
          or (json.devDependencies and json.devDependencies["@angular/core"])

        return version and version:match("(%d+%.%d+%.%d+)")
      end

      local function warn(msg)
        vim.schedule(function()
          vim.notify("[angularls] " .. msg, vim.log.levels.WARN)
        end)
      end

      local function file_exists(path)
        return vim.uv.fs_stat(path) ~= nil
      end

      local function get_cmd(root_dir)
        local probe_dir = get_probe_dir(root_dir)
        local version_str = get_angular_core_version(root_dir)
        if not version_str then
          warn("Could not detect @angular/core version.")
          return nil
        end

        local major = tonumber(version_str:match("^(%d+)"))
        local lang_server_root = probe_dir .. "/@angular/language-server"
        local lang_service_path = probe_dir .. "/@angular/language-service"

        -- Check for presence of language-server
        if not file_exists(lang_server_root) then
          warn(
            "@angular/language-server is not installed. Please run `npm install -D @angular/language-server`."
          )
          return nil
        end

        -- Angular 17+ (requires language-service + index.js entrypoint)
        if major >= 17 then
          if not file_exists(lang_service_path) then
            warn(
              "@angular/language-service is required for Angular "
                .. major
                .. "+. Please run `npm install -D @angular/language-service`."
            )
            return nil
          end

          return {
            "node",
            lang_server_root .. "/index.js",
            "--stdio",
            "--tsProbeLocations",
            probe_dir,
            "--ngProbeLocations",
            probe_dir,
            "--angularCoreVersion",
            version_str,
          }
        end

        -- Angular 16 or older (uses ngserver binary)
        local ngserver_bin =
          vim.fn.exepath(root_dir .. "/node_modules/.bin/ngserver")
        if ngserver_bin == "" then
          warn(
            "Could not find ngserver binary in project. Is Angular < 17 installed?"
          )
          return nil
        end

        return {
          ngserver_bin,
          "--stdio",
          "--tsProbeLocations",
          probe_dir,
          "--ngProbeLocations",
          probe_dir,
        }
      end

      local lspconfig = require("lspconfig")

      lspconfig.angularls.setup({
        cmd = get_cmd(vim.fn.getcwd()), -- fallback for initial load
        filetypes = { "typescript", "html", "typescriptreact" },
        root_dir = util.root_pattern("angular.json"),
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd = get_cmd(new_root_dir)
        end,
      })
    end,
  },
}
