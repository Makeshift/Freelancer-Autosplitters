# Autosplitters for Freelancer

## Current Autosplitters

### Any%

#### Many Objectives
This splitter contains a lot of objectives, and splits based on your current objective in-game. I attempted to make include as many splits as I could that could be used for optimising small sections.

**Features**:
* Splits on many major (and minor) points in each mission
* If you skip a split, it will catch up and continue attempting to autosplit
* If it gets behind, it will attempt to skip to the next relevant split when you level up (beta)
* Fairly customisable, you can enable/disable splits for sections in the options

## TODO
If anybody can find a pointer to the players current rank that isn't in `server.dll`, that would be awesome. It looks like `server.dll` gets moved around a lot in memory (especially on game load), and it's difficult to get LiveSplit/CheatEngine to keep up with the moving memory addresses.

## Debugging
The autosplitters are set to log out useful information. To access this logging information, use [DebugView](https://docs.microsoft.com/en-us/sysinternals/downloads/debugview). If you can include logging information when reporting an issue, it will be immensely helpful.

## Issues? Suggestions?
Please check for an open an issue [here](https://github.com/Makeshift/Freelancer-Autosplitters/issues), or open one yourself.

If you're tech-savvy, feel free to open a [pull request](https://github.com/Makeshift/Freelancer-Autosplitters/pulls) with changes.

