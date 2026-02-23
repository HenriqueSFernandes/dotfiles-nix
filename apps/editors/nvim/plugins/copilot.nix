{ ... }:
{
  programs.nixvim.plugins = {
    copilot-vim.enable = true;
    copilot-chat.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>cc";
      action.__raw = "require('CopilotChat').toggle";
      options.desc = "Toggle Chat Window";
    }
    {
      mode = "n";
      key = "<leader>ce";
      action = ":Copilot enable<CR>";
      options.desc = "Enable Copilot";
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = ":Copilot disable<CR>";
      options.desc = "Disable Copilot";
    }
    {
      mode = "n";
      key = "<leader>cpe";
      action = ":CopilotChatExplain<CR>";
      options.desc = "Explain Code";
    }
    {
      mode = "n";
      key = "<leader>cpr";
      action = ":CopilotChatReview<CR>";
      options.desc = "Review Code";
    }
    {
      mode = "n";
      key = "<leader>cpf";
      action = ":CopilotChatFix<CR>";
      options.desc = "Fix Code";
    }
    {
      mode = "n";
      key = "<leader>cpo";
      action = ":CopilotChatOptimize<CR>";
      options.desc = "Optimize Code";
    }
    {
      mode = "n";
      key = "<leader>cpd";
      action = ":CopilotChatDocs<CR>";
      options.desc = "Generate Documentation";
    }
    {
      mode = "n";
      key = "<leader>cpt";
      action = ":CopilotChatTests<CR>";
      options.desc = "Generate Tests";
    }
    {
      mode = "n";
      key = "<leader>cpD";
      action = ":CopilotChatTests<CR>";
      options.desc = "Generate Tests";
    }
    {
      mode = "n";
      key = "<leader>cpc";
      action = ":CopilotChatCommit<CR>";
      options.desc = "Generate Commit Message";
    }
    {
      mode = "n";
      key = "<leader>cpC";
      action = ":CopilotChatCommitStaged<CR>";
      options.desc = "Generate Staged Commit Message";
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>cq";
      action.__raw = ''
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = vim.api.nvim_get_current_buf() })
          end
        end
      '';
      options.desc = "CopilotChat - Quick chat";
    }
  ];
}
