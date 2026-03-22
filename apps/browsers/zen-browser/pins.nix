{ config, ... }:
{

  programs.zen-browser.profiles.${config.home.username} = {
    pins =
      let
        containers = config.programs.zen-browser.profiles.${config.home.username}.containers;
      in
      {
        # Personal
        # FEUP
        "moodle" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
          container = containers.FEUP.id;
          url = "https://moodle.up.pt";
          isEssential = true;
          position = 101;
        };
        "email" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a170";
          container = containers.FEUP.id;
          url = "https://outlook.office365.com/mail/";
          isEssential = true;
          position = 102;
        };
        "drive" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a171";
          container = containers.FEUP.id;
          url = "https://drive.google.com";
          isEssential = true;
          position = 103;
        };
        # NIAEFEUP
        # ACM
      };

  };
}

