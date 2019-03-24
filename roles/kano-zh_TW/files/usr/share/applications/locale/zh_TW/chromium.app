{
    "title": "瀏覽器",
    "tagline": "Internet Browser",
    "description": "Browse the web with Chromium - the open-source cousin of Google Chrome! You can bookmark sites, search, and explore. For faster loading, open up sites that have plenty of text, like Wikipedia or Google News. To watch videos, use the YouTube or Media apps.",
    "slug": "chromium",

    "icon": "chromium-app",
    "colour": "#7fa9cf",

    "categories": ["tools"],

    "packages": [],
    "dependencies": ["chromium-browser", "kano-profile"],
    "launch_command": "kano-tracker-ctl session run 'chromium-browser' '/usr/bin/kano-start-browser'",
    "overrides": ["chromium.desktop", "chromium-browser.desktop",
                  "lxde-x-www-browser.desktop", "epiphany-newtab.desktop"],

    "priority": 650
}