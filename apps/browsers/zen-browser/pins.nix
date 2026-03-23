{ config, ... }:
{

  programs.zen-browser.profiles.${config.home.username} = {
    pins =
      let
        containers = config.programs.zen-browser.profiles.${config.home.username}.containers;
        spaces = config.programs.zen-browser.profiles.${config.home.username}.spaces;
        pins = config.programs.zen-browser.profiles.${config.home.username}.pins;
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

        # Moodle courses
        "Moodle" = {
          id = "d85a9026-1458-4db6-b115-346746bcc692";
          workspace = spaces.FEUP.id;
          isGroup = true;
          isFolderCollapsed = false;
          editedTitle = true;
          position = 200;
        };
        "ASSO" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
          workspace = spaces.FEUP.id;
          folderParentId = pins."Moodle".id;
          url = "https://moodle2526.up.pt/course/view.php?id=4837";
          editedTitle = true;
          position = 201;
        };
        "GEE" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c78";
          workspace = spaces.FEUP.id;
          folderParentId = pins."Moodle".id;
          url = "https://moodle2526.up.pt/course/view.php?id=4176";
          editedTitle = true;
          position = 202;
        };
        "GRS" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c79";
          workspace = spaces.FEUP.id;
          folderParentId = pins."Moodle".id;
          url = "https://moodle2526.up.pt/course/view.php?id=4391";
          editedTitle = true;
          position = 203;
        };
        "CPA" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c80";
          workspace = spaces.FEUP.id;
          folderParentId = pins."Moodle".id;
          url = "https://moodle2526.up.pt/course/view.php?id=4917";
          editedTitle = true;
          position = 204;
        };
        "LGP" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c81";
          workspace = spaces.FEUP.id;
          folderParentId = pins."Moodle".id;
          url = "https://moodle2526.up.pt/course/view.php?id=7607";
          editedTitle = true;
          position = 205;
        };
        # NIAEFEUP
        # ACM
      };

  };
}

