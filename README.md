# Flagship - Scrapyard
Tower defense game but with barcode scanners

itch.io:
	
## How to play
1. Start the game
2. Get points by eliminating all enemys by selecting the right tower with the barcode scanner
3. Spend you points on upgrades
	
## Images


# To-Do List
- Set up enemys and their path
- set up reloading for each tower
- make towers explode when scanned
- point system
- make map system, on screen and physical
- add a increased dificulty
- shop? w/ faster reload, more damage per blast, bigger radius
	- have shop always active on a second paper with upgrades you can buy at any time with pooints

# Gameplay Loop
- Level starts (could add an indicator for when its each level, like a flash or something)
- Enemys start spawning in and follow the path
- the towers are always set and active in thier repsective locations
- when the player scans the physical barcode in front og them, they activate the tower
- the goal is to not let the enemys reach the end of the screen
- you get points for each enemy killed
- points work on a seperate shop page, whihc when scanned can add things like bigger radius of tower power, fast reload for tower, and speed?
- more enemys later, this is further down the lime, like faster enemys, stronger ones, boss enemy (it looks big and has a lot of health?)
- death condition, too many enemys leak??

# proposed how it works
- towers, in one script contorling them, changed for each scene of said 5 towers
- enemys is one scene, different propeties, all follow the same path
- shop, make way to track and have points, shop script on its own
- physical controler, make it look trashed

# Shop Prices
- Faster Reload - decreases by 1/10th of a second, 10
