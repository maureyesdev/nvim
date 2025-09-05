-- TODO: Need to put the cspell file formats in a var, Need to put the cspell global path in a var...
-- ... for find_cspell_config and get_cspell_path_for_write

return {
  "lucaSartore/fastspell.nvim",
  build = function()
    local base = vim.fn.stdpath("data") .. "/lazy/fastspell.nvim"
    local script = base
      .. "/lua/scripts/install."
      .. (vim.fn.has("win32") == 1 and "cmd" or "sh")
    vim.system({ script })
  end,
  config = function()
    local fastspell = require("fastspell")

    ---------------------------------------------------------------------------
    -- cspell config: prefer project file, else global (~/.config/cspell/cspell.json)
    ---------------------------------------------------------------------------
    local function find_cspell_config()
      local cwd = vim.fn.getcwd()
      for _, p in ipairs({
        cwd .. "/cspell.json",
        vim.fn.expand("~/.config/cspell/cspell.json"),
      }) do
        if vim.fn.filereadable(p) == 1 then
          return p
        end
      end
      return nil
    end

    fastspell.setup({
      namespace = "fastspell",
      filter_by_buf_type = true,
      diagnostic_severity = vim.diagnostic.severity.INFO,
      cspell_json_file_path = find_cspell_config(),
    })

    ---------------------------------------------------------------------------
    -- Safe reload + throttle + full recheck (scheduled to avoid fast-event errors)
    ---------------------------------------------------------------------------
    local reload_inflight = false
    local function reload_fastspell()
      if reload_inflight then
        return
      end
      reload_inflight = true
      vim.schedule(function()
        local ok, lazy = pcall(require, "lazy")
        if ok then
          lazy.reload({ plugins = { "fastspell.nvim" } })
        end
        vim.defer_fn(function()
          reload_inflight = false
          local buf = vim.api.nvim_get_current_buf()
          pcall(function()
            require("fastspell").sendSpellCheckRequest(
              0,
              vim.api.nvim_buf_line_count(buf)
            )
          end)
        end, 100)
      end)
    end

    ---------------------------------------------------------------------------
    -- JSON helpers: read/write + async pretty print (jq → prettier → noop)
    ---------------------------------------------------------------------------
    local function has(cmd)
      return vim.fn.executable(cmd) == 1
    end

    -- WIP
    -- Format JSON file on disk asynchronously.
    -- After formatting, schedule a :checktime and then on_done().
    --- @param path string
    --- @param on_done? fun()
    local function format_json_file(path, on_done)
      on_done = on_done or function() end
      local function done()
        vim.schedule(function()
          pcall(vim.cmd, "checktime") -- reload buffers changed externally
          on_done()
        end)
      end

      if has("jq") and has("sh") then
        local cmd = ([[jq . %q > %q.tmp && mv %q.tmp %q]]):format(
          path,
          path,
          path,
          path
        )
        vim.system({ "sh", "-c", cmd }, { text = false }, function()
          done()
        end)
        return
      end

      if has("prettier") then
        vim.system(
          { "prettier", "--loglevel", "silent", "--write", path },
          { text = false },
          function()
            done()
          end
        )
        return
      end

      done() -- no formatter available → keep minified
    end

    local function read_json(path)
      local ok, content = pcall(vim.fn.readfile, path)
      if not ok then
        return nil
      end
      local text = table.concat(content, "\n")
      local ok2, obj = pcall(vim.json.decode, text)
      if not ok2 then
        return nil
      end
      return obj
    end

    local function write_json(path, obj)
      local text = vim.json.encode(obj)
      vim.fn.writefile({ text }, path)
      format_json_file(path)
    end

    local function get_cspell_path_for_write()
      local cwd = vim.fn.getcwd()
      for _, p in ipairs({ cwd .. "/cspell.json" }) do
        if vim.fn.filereadable(p) == 1 then
          return p, "project"
        end
      end
      local global = vim.fn.expand("~/.config/cspell/cspell.json")
      if vim.fn.filereadable(global) == 0 then
        vim.fn.mkdir(vim.fn.fnamemodify(global, ":h"), "p")
        vim.fn.writefile({ '{ "version": "0.2", "words": [] }' }, global)
      end
      return global, "global"
    end

    ---------------------------------------------------------------------------
    -- word helper (project → global) + hot reload
    ---------------------------------------------------------------------------
    local function add_word(word)
      word = word or vim.fn.expand("<cword>")
      if not word or word == "" then
        vim.notify("fastspell: no word under cursor", vim.log.levels.WARN)
        return
      end
      local path, scope = get_cspell_path_for_write()
      local cfg = read_json(path) or { version = "0.2", words = {} }
      cfg.words = cfg.words or {}
      for _, w in ipairs(cfg.words) do
        if w == word then
          vim.notify(
            ("'%s' already in %s dictionary"):format(word, scope),
            vim.log.levels.INFO
          )
          return
        end
      end
      table.insert(cfg.words, word)
      write_json(path, cfg)
      vim.notify(
        ("Added '%s' to %s cspell.json\n%s"):format(word, scope, path),
        vim.log.levels.INFO
      )
      reload_fastspell()
    end

    vim.keymap.set("n", "<leader>sa", function()
      add_word()
    end, { desc = "[S]pell [A]dd word" })

    vim.api.nvim_create_user_command("FastspellAddWord", function(opts)
      add_word(opts.args ~= "" and opts.args or nil)
    end, { nargs = "?" })

    ---------------------------------------------------------------------------
    -- Auto-format + reload when manually editing cspell.json (de-duplicated)
    ---------------------------------------------------------------------------
    local watch_group =
      vim.api.nvim_create_augroup("FastspellCspellWatch", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = watch_group,
      pattern = { "cspell.json", ".cspell.json" },
      callback = function(args)
        format_json_file(args.match, reload_fastspell) -- on_done is scheduled
      end,
      desc = "Format cspell.json then reload fastspell",
    })

    ---------------------------------------------------------------------------
    -- Normal-mode, full-buffer checks (no realtime typing checks)
    ---------------------------------------------------------------------------
    local group =
      vim.api.nvim_create_augroup("FastspellFullBuffer", { clear = true })

    local function check_full_buffer()
      local buf = vim.api.nvim_get_current_buf()
      fastspell.sendSpellCheckRequest(0, vim.api.nvim_buf_line_count(buf))
    end

    -- when opening buffer, leaving insert, or saving — run full sweep
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
      group = group,
      callback = function()
        vim.schedule(check_full_buffer)
      end,
      desc = "fastspell: full-buffer spell check",
    })

    -- manual command & key to run it on demand
    vim.api.nvim_create_user_command(
      "FastspellCheckBuffer",
      check_full_buffer,
      {}
    )
    vim.keymap.set(
      "n",
      "<leader>sc",
      check_full_buffer,
      { desc = "[S]pell [C]heck buffer" }
    )

    ---------------------------------------------------------------------------
    -- Snacks spelling picker on `gh` (fallback to `z=`)
    ---------------------------------------------------------------------------
    local function open_spelling_picker()
      local ok, Snacks = pcall(require, "snacks")
      if ok and Snacks and Snacks.picker and Snacks.picker.spelling then
        Snacks.picker.spelling()
      else
        vim.cmd("normal! z=")
      end
    end
    vim.keymap.set(
      { "n", "v" },
      "<leader>ss",
      open_spelling_picker,
      { desc = "Spelling suggestions (Snacks or z=)" }
    )
  end,
}
