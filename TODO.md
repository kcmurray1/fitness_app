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
- give 1 second gap between timer switch. [X]: Timer uses microseconds instead of milliseconds 
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

**TODO #1:** Specify sets in a round [x]
- make round card
- addSet() adds a timer
- removeSet() removes a timer
**TODO #2** [x]
- removing rounds removes the round at the end of the list and not the round that we want to remove 
**TODO #3:**
- option to select rounds as pages (1-2, all, etc)
    - select sets within the round (odd, even, 1-2, etc.)
**TODO #4:** Improve UI
- Simple time settings [x]
	- adding rounds adds default 
- Advanced time settings [x]
	- make rounds into individual cards
	- edit/delete rounds	
- Timer Page
	- alternate colors between work and rest time [x]
	- Audio
		- ticking noise for the last 3-5 seconds
**TODO #5**
- Timer Page [x]
	- Adjust timer_page so that leaving will stop the timer, currently, leaving the page while running will cause a dispose exception [x]
- SettingsPage [x]
	- Add IntervalTimer name field [x]
	- update Advanced settings page to remove empty rounds from the page(refer to timer_page use of removeEmptyRounds()) [x]
- SelectorPage
	- Update UI
		- Build widget for Quickstart [x]
		- hide clear all button(keep for debug purposes) [x]
		- Determine how to display work and rest information for timers [x] // displays average
***TODO #6 ***
- GeneralSettingsPage
	- add settings page
	- option to select time on/off color

**State Organization** [x]
- remove use of changenotifierprovider in main.dart [x]
- adjust build in timer_settings_page to use this instead to localize changes [x]
- same applies to timer_page [x]
- then figure out how to save changes to user_timers.json [x]
	- data changes but have to refresh in ide to see changes. [x]
