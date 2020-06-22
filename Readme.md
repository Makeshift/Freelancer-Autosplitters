# Autosplitters for Freelancer

## Current Autosplitters

### Any%

#### Many Objectives
This splitter contains a lot of objectives, and splits based on your current objective in-game. I attempted to include as many splits as I could so that it could be used to optimising small sections.

**Features**:
* Splits on many major (and minor) points in each mission
* If you skip a split, it will catch up and continue attempting to autosplit
* If it gets behind, it will attempt to skip to the next relevant split when you level up (beta)
* Fairly customisable, you can enable/disable splits for sections in the options
* The timer starts after clicking 'New Game', on the frame the cutscene starts
* The timer ends the frame the Nomad City destruction cutscene starts

**Known Issues**:
* Some objectives which should obviously be separate are rolled into one. This is usually because Freelancer only has unique ID's for *most* objectives, or cleverly re-uses them sometimes, making it difficult to figure out exactly where in a mission we are. There is no fix for this at the moment.
* Sometimes, a split will happen slightly earlier or slightly later than you'd expect - This is due to Freelancer changing your objective at weird times, or because a cutscene skip skips over a trigger that updates your objective. It should still be consistent between runs, so it shouldn't really be a problem. This would be fixable if we can find a consistent pointer to the players current rank.
* The "Skip to Mission X on level-up" option is incomplete, due to the above.
* This has only been tested on game version v1.0. I have not tested it on any patches.

## How To Use
* Click the "Source Code (zip)" button below.
* Unzip into a folder of your choice
* Open LiveSplit
* Right-click LiveSplit, go to 'Edit Layout' (If you do not have a LiveSplit layout, you can click 'Open Layout' -> 'From File' and select `Freelancer - any% Many Objectives.lsl` for a basic layout)
* Add a 'Scriptable Auto Splitter', with the script pointed to `Freelancer - any% Many Objectives.asl`
* Right-click on LiveSplit again, click 'Open Splits' -> 'From File'
* Choose `Freelancer - any% Many Objectives.lss`

## TODO
If anybody can find a pointer to the players current rank that isn't in `server.dll`, that would be awesome. It looks like `server.dll` gets moved around a lot in memory (especially on game load), and it's difficult to get LiveSplit/CheatEngine to keep up with the moving memory addresses.

## Debugging
The autosplitters are set to log out useful information. To access this logging information, use [DebugView](https://docs.microsoft.com/en-us/sysinternals/downloads/debugview). If you can include logging information when reporting an issue, it will be immensely helpful.

## Issues? Suggestions?
Please check for an open an issue [here](https://github.com/Makeshift/Freelancer-Autosplitters/issues), or open one yourself.

If you're tech-savvy, feel free to open a [pull request](https://github.com/Makeshift/Freelancer-Autosplitters/pulls) with changes.

