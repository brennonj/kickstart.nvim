-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<C-y>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      -- Keymaps
      vim.keymap.set({ 'n', 'v' }, '<leader>cc', '<cmd>CopilotChatToggle<cr>', { desc = '[C]opilot [C]hat Toggle' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ce', '<cmd>CopilotChatExplain<cr>', { desc = '[C]opilot [E]xplain' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ct', '<cmd>CopilotChatTests<cr>', { desc = '[C]opilot Generate [T]ests' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cr', '<cmd>CopilotChatReview<cr>', { desc = '[C]opilot [R]eview' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cf', '<cmd>CopilotChatFix<cr>', { desc = '[C]opilot [F]ix' })
      vim.keymap.set({ 'n', 'v' }, '<leader>co', '<cmd>CopilotChatOptimize<cr>', { desc = '[C]opilot [O]ptimize' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cd', '<cmd>CopilotChatDocs<cr>', { desc = '[C]opilot [D]ocs' })
      vim.keymap.set('n', '<leader>cq', function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end, { desc = '[C]opilot [Q]uick Chat' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      -- Keymaps
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [A]dd file' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon toggle menu' })

      -- Jump to specific files
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon file 1' })

      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon file 2' })

      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon file 3' })

      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon file 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon previous' })

      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon next' })
    end,
  },
}
