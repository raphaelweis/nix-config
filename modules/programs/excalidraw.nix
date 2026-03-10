{
  flake.modules.homeManager.excalidraw = {
    # use chromium for excalidraw because:
    # 1. Chrome's implementation of web apps is better than firefox's
    # 2. Firefox filesystem API is limited and cannot write to an existing
    # file, which makes using excalidraw impractictal on firefox.
    xdg.desktopEntries.excalidraw = {
      type = "Application";
      name = "Excalidraw";
      exec = "chromium --app=https://excalidraw.com";
      icon = ../../assets/excalidraw.svg;
      categories = [
        "Graphics"
        "Network"
        "WebBrowser"
      ];
    };
  };
}
