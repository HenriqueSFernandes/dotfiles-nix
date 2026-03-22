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
      NIAEFEUP = {
        color = "red";
        icon = "briefcase";
        id = 3;
      };
      ACM = {
        color = "blue";
        icon = "briefcase";
        id = 4;
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
        "NIAEFEUP" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40b";
          position = 3;
          container = containers.NIAEFEUP.id;
          theme.colors = [
            {
              red = 243;
              green = 139;
              blue = 168;
            }
          ];
        };
        "ACM" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40c";
          position = 4;
          container = containers.ACM.id;
          theme.colors = [
            {
              red = 137;
              green = 180;
              blue = 250;
            }
          ];
        };
      };
  };
}
