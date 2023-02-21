{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.85;
      };
      font = {
        normal = {
          family = "MesloLGS Nerd Font";
          style = "Medium";
        };
        bold = {
          family = "MesloLGS Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "MesloLGS Nerd Font";
          style = "MediumItalic";
        };
        bold_italic = {
          family = "MesloLGS Nerd Font";
          style = "BoldItalic";
        };
        size = 12;
      };
      draw_bold_text_with_bright_colors = true;
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
      };
      colors = {
        primary = {
          background = "0x2e3436";
          foreground =  "0xd3d7cf";
        };
  
        normal= {
          black= "0x2e3436";
          red= "0xcc0000";
          green= "0x4e9a06";
          yellow= "0xc4a000";
          blue= "0x3465a4";
          magenta= "0x75507b";
          cyan= "0x06989a";
          white= "0xd3d7cf";
        };

        bright= {
          black= "0x555753";
          red= "0xef2929";
          green= "0x8ae234";
          yellow= "0xfce94f";
          blue= "0x729fcf";
          magenta= "0xad7fa8";
          cyan= "0x34e2e2";
          white= "0xeeeeec";
        };
      };
    };
  };
}