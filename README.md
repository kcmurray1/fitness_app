fitness app plan
TIMER
1) create interval timing feature
	a- x seconds on, y seconds rest [x]
	b- Micro intervals [x]
		- x seconds of z seconds, a seconds [x] // x rounds of y sets
	c- Changing intervals
		- x intervals starting at 30 seconds decrementing/incrementing by y seconds
			- 30 - x, 30 - 2x, 30 - 3x
		- check that  30 - y * x >= 0 (can't have negative intervals)
	d - connect with user input(textfields) [x]
	
2) MAP
	a- connect to google maps API
	b- learn how to use tracking features for running/walking
	c- learn how to edit the map
		- display beacons for each mile and breakdown(pace, elevation, distance)
**TODO**:
1a): implement time off logic [x]
	- give 1 second gap between timer switch.
		-refactor Phasetimer to compose of both work and rest (hence a phase) [x]
	- add rounds (increment) [x]
		- currently does not work with more than 1 phaseTimer, it pauses between the transition [x]
	- maybe add sound(beep) for the last 3 seconds 

Functionality Example:) '+': work time, '=': rest time
    Rounds / Exercises(sets)
    1: + 30, =10
       + 30, =10
    2: + 15, =15 // Decrease work by 1/2 and increase rest
       + 15, =15
    3: + 7, =10 // Decrease work by 1/2 
       + 7, =20 // allow individual adjustment of time(s)

**NOTE #1:** Specify sets in a round [x]
    - make round card
    - addSet() adds a timer
    - removeSet() removes a timer
**NOTE #2** [x]
	- removing rounds removes the round at the end of the list and not the round that we want to remove 
**NOTE #3:**
    - option to select rounds as pages (1-2, all, etc)
        - select sets within the round (odd, even, 1-2, etc.)
**NOTE #4:** Improve UI
	- Simple time settings [x]
		- adding rounds adds default 
	- Advanced time settings [x]
		- make rounds into individual cards
		- edit/delete rounds	
	- Timer Page
		- alternate colors between work and rest time
		- Audio
			- ticking noise for the last 3-5 seconds
		