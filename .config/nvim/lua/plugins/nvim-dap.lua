return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "leoluz/nvim-dap-go",
      opts = {},
    },
  },
  config = function()
    local dap, dap_ui = require("dap"), require("dapui")

    dap_ui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dap_ui.close()
    end

    vim.api.nvim_set_hl(
      0,
      "DapStoppedLine",
      { default = true, link = "Visual" }
    )
  end,
  keys = {
    {
      "<F1>",
      function()
        require("dap").toggle_breackpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<F2>",
      function()
        require("dap").continue()
      end,
      desc = "Run / Continue",
    },
    {
      "<F11>",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<F12>",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<F3>",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<F4>",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<F6>",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<F7>",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<F8>",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<F9>",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<F10>",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },
}
