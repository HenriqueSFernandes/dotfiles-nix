{ config, ... }:
{
  programs.zen-browser.profiles.${config.home.username} = {
    containersForce = true;
    containers = {
      Personal = {
        color = "green";
        icon = "fingerprint";
        id = 1;
      };
      FEUP = {
        color = "orange";
        icon = "briefcase";
        id = 2;
      };
    };
    spacesForce = true;
    spaces =
      let
        containers = config.programs.zen-browser.profiles.${config.home.username}.containers;
      in
      {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1;
          container = containers.Personal.id;
          theme.colors = [
            {
              red = 30;
              green = 30;
              blue = 46;
            }
          ];
        };
        "FEUP" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40d";
          position = 2;
          container = containers.FEUP.id;
          theme.colors = [
            {
              red = 250;
              green = 179;
              blue = 135;
            }
          ];
        };
      };
  };
}
