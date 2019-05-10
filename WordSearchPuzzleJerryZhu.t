%Jerry Zhu
%Mr. Rosen
%May 18, 2018
%This program is my ISP for grade 10 ICS. It is a word search puzzle.

%Sets up the screen
import GUI
var mainWindow := Window.Open ("position:250;200;graphics:640,400")
setscreen ("nooffscreenonly")

%Forwarding procedures
forward procedure mainMenu
forward procedure userInput
forward procedure display
forward procedure timedWindow
forward procedure instructions

%Declaration Section
var puzzleNumber, puzzleType, usedNumber1, usedNumber2 : int := 0 %1.Number of puzzles the user has done 2.the types of puzzle. 3. the first puzzle the user did 4. the second puzzle the user did
var programTimeElapsed : int := Time.Elapsed %Sets a variable to store the Time.Elapsed for the program
var userTime : string := "0" %The variable to get what the user enters for the timer value
var realUserTime : real %Does the calculations after the user inputs the timer value
var exitLoop, winChecker : boolean := false %1. exits the loop when a certain condition is met 2. checks if the user wins
var menuExitLoop : boolean := true %Exits the userInput loop if the user goes to main menu
var startLetter, endLetter : array 1 .. 2 of int := init (0, 0) %letters that the user input
var startingLetterX, startingLetterY, endingLetterX, endingLetterY : array 1 .. 15 of int %positions of words
var wordBank1 : array 1 .. 15 of string
    := init ("Ant", "Bee", "Cat", "Cow", "Deer", "Dog", "Fish", "Fly", "Fox", "Goat", "Mouse", "Owl", "Pig", "Shark", "Wolf") %Word bank
var wordBank2 : array 1 .. 15 of string
    := init ("Apple", "Apricot", "Avocado", "Banana", "Cherry", "Coconut", "Grape", "Guava", "Lemon", "Lime", "Mango", "Orange", "Peach", "Pear", "Plum") %Word bank
var wordBank3 : array 1 .. 15 of string
    := init ("Argument", "Body", "Boolean", "Chaining", "Class", "Flag", "Iteration", "Loop", "Method", "Overloading", "Package", "Parameter", "Recursion", "Typecast", "Void") %Word bank
var checkWord : array 1 .. 15 of boolean := init (false, false, false, false, false, false, false, false, false, false, false, false, false, false, false) %checks words
var timeBtn := GUI.CreateButton (265, 150, 0, "Timed Mode", timedWindow) %Timed Mode Button
var untimedBtn := GUI.CreateButton (260, 110, 0, "Untimed Mode", userInput) %Untimed Mode Button
var instructionsBtn := GUI.CreateButton (265, 70, 0, "Instructions", instructions) %Instructions button
var mainMenuBtn := GUI.CreateButton (270, 100, 0, "Main Menu", mainMenu) %main menu button
var exitBtn : int := GUI.CreateButton (285, 30, 0, "Quit", GUI.Quit) %exit button

%Hides Buttons
GUI.Hide (exitBtn)
GUI.Hide (instructionsBtn)
GUI.Hide (timeBtn)
GUI.Hide (untimedBtn)

%Start Music
process failMusic
    Music.PlayFile ("fail-trombone-01.mp3")
end failMusic

process winMusic
    Music.PlayFile ("Sports_Crowd-GoGo-2100314571.mp3")
end winMusic

process hotCrossBuns
    Music.Play (">>4ba2g4ba2g8ggggaaaa4ba2g<4ba2g4ba2g8ggggaaaa4ba2g")
end hotCrossBuns
%End music

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Procedure Section %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Program title
procedure title
    cls
    locate (1, 31)
    put "Word Search Puzzle" %Prints the title
end title

%Program wordChecker - checks if a word is selected
procedure wordChecker
    %Convert the user input letters from pixels to grid coordinates
    startLetter (1) := (startLetter (1) - 200) div 20
    startLetter (2) := (startLetter (2) - 80) div 20
    endLetter (1) := (endLetter (1) - 200) div 20
    endLetter (2) := (endLetter (2) - 80) div 20

    %Local Declaration
    var gottenWords : int := 0 %Resets user words

    %Word processing
    for x : 1 .. 15
	%If the user inputted letters thats equal to the location of words
	if startLetter (1) = startingLetterX (x) and startLetter (2) = startingLetterY (x) and endLetter (1) = endingLetterX (x) and endLetter (2) = endingLetterY (x) then
	    % Check if a word is selected
	    checkWord (x) := true
	end if

	%If the user gets a word then the word count goes up by 1
	if checkWord (x) = true then
	    gottenWords := gottenWords + 1 %Word count
	end if
    end for

    %If the user gets 15 words then randomly moves to another puzzle
    if gottenWords = 15 then
	delay (500) %transitioning time
	userInput %Chooses the puzzle
    end if
end wordChecker

%Program intro
procedure intro
    title
    fork hotCrossBuns

    %Local Declaration
    var fontIntro : int := Font.New ("arial:20")

    %Sets up buttons
    GUI.Show (mainMenuBtn)

    Font.Draw ("Welcome to the Word Search Puzzle!", 100, 330, fontIntro, red) %Draws the intro

    %Intro Animation
    for x : 0 .. 400
	drawfillbox (x - 171, 130, x - 10, 280, white) %Erase
	drawfillbox (x - 170, 130, x - 10, 280, purple) %Black Box

	drawfilloval (x - 90, 230, 30, 30, black) %Outer Circle of the glass
	drawfilloval (x - 90, 230, 23, 23, white) %Inner Circle of the glass

	drawfillbox (x - 95, 176, x - 85, 205, black) %Top part of the handle
	drawfillbox (x - 95, 140, x - 85, 174, black) %Bottom part of the handle
	delay (1)
	View.Update %Removes flashing
    end for
end intro

%Program mainMenu
body procedure mainMenu
    title

    %Resets values for variables so that theres a new game each time
    realUserTime := 0  %resets timer value
    exitLoop := false  %resets exit
    puzzleNumber := 0  %resets puzzles
    Music.PlayFileStop %stops all music

    randint (puzzleType, 1, 3) %Chooses the puzzle

    %Sets up the buttons
    GUI.Hide (mainMenuBtn)
    GUI.Show (exitBtn)
    GUI.Show (untimedBtn)
    GUI.Show (timeBtn)
    GUI.Show (instructionsBtn)
end mainMenu


%Program instructions
body procedure instructions
    title

    %Sets up Buttons
    GUI.Hide (exitBtn)
    GUI.Hide (timeBtn)
    GUI.Hide (untimedBtn)
    GUI.Hide (instructionsBtn)
    GUI.Show (mainMenuBtn)

    %Instructions Text
    locate (3, 1)
    put "To Play: Choose timed mode to start a new game with a timer; choose untimed mode"
    locate (4, 10)
    put "for a untimed game. A timed game is with a time limit to beat all 3 "
    locate (5, 10)
    put "puzzles."
    locate (7, 1)
    put "Game: There are 15 words in each of the 3 word searches. Press the first and"
    locate (8, 7)
    put "last letter of each word. To win, find all of the words and beat the 3"
    locate (9, 7)
    put "puzzles."
    locate (11, 1)
    put "To Quit: Simply press quit."
end instructions

%Program timedWindow - gets the time
body procedure timedWindow
    %Local Declaration
    var timeWindow : int := Window.Open ("position: 700;300 , graphics: 640;400")

    %Sets up the screen
    Window.Hide (mainWindow)
    Window.Select (timeWindow)

    title %Calls title after Window select so it shows in the new window

    %Gets user's desired time limit
    locate (3, 1)
    put "Enter your time in seconds: " ..
    get userTime

    %Timer Error trap
    if not (strrealok (userTime)) or strreal (userTime) <= 0 or strreal (userTime) > 100000 then %Errortraps if the user inputs a string, zero, a negative number or a number bigger than 100000
	put ""
	put "Please Enter a Positive Number Greater than 0 and Less than 100000!" %Text
	delay (1000) %1 second to start again
	Window.Hide (timeWindow) %Closes window
	timedWindow %Asks for a new window
    end if

    %Timer
    if strreal (userTime) > 0 then
	%Converts variable userTime
	if strrealok (userTime) = true then
	    realUserTime := strreal (userTime) %Sets realUserTime equal to the inputted userTime
	end if

	%sets up output
	Window.Select (mainWindow) %Selects output window
	Window.Hide (timeWindow) %Hides time window
	Window.Show (mainWindow) %Shows main window
	userInput %calls userInput
    end if
end timedWindow

%Program userInput - Game and Processing
body procedure userInput
    title

    %Local Declaration
    var fontWordBank : int := Font.New ("arial:20") %Font
    var font1 : int := Font.New ("calibri:11") %Font
    var loopTimeElapsed : int %Time.Elapsed for the loop
    var puzzleLetters, topic : string %1. puzzle's letters 2. topic of the puzzles
    var button, letterX, letterY : int %Mousewhere variables
    var puzzleWords : array 1 .. 15 of string %Words for the puzzles
    var timerChecker : boolean := false %Timer exit loop checker
    menuExitLoop := false %Resets the menu exit loop
    puzzleNumber := puzzleNumber + 1

    %Sets up Buttons
    GUI.Hide (exitBtn)
    GUI.Hide (timeBtn)
    GUI.Hide (untimedBtn)
    GUI.Hide (instructionsBtn)
    GUI.Hide (mainMenuBtn)
    mainMenuBtn := GUI.CreateButton (270, 5, 0, "Main Menu", mainMenu)

    %Chooses the puzzle randomly with no repeats
    if puzzleNumber = 1 then %First puzzle
	usedNumber1 := puzzleType %Stores a used value for the puzzleType
	locate (10, 66)
	put "First puzzle" .. %To show which puzzle it is
    elsif puzzleNumber = 2 then %Second puzzle
	randint (puzzleType, 1, 3) %Chooses a puzzle

	%Makes sure puzzleType is different
	loop
	    exit when puzzleType not= usedNumber1

	    %Keeps randomizing
	    if puzzleType = usedNumber1 then
		randint (puzzleType, 1, 3) %keeps randomizing until puzzleType is different from previoys values
	    end if
	end loop
	usedNumber2 := puzzleType %Stores a used value
	locate (10, 66)
	put "Second Puzzle" .. %To show which puzzle it is
    elsif puzzleNumber = 3 then
	randint (puzzleType, 1, 3) %Chooses a puzzle

	%Makes sure puzzleType is different
	loop
	    exit when (puzzleType not= usedNumber2) and (puzzleType not= usedNumber1)

	    %Keeps randomizing
	    if puzzleType = usedNumber1 or puzzleType = usedNumber2 then
		randint (puzzleType, 1, 3) %keeps randomizing until puzzleType is different from previoys values
	    end if
	end loop
	locate (10, 66)
	put "Last puzzle" .. %To show which puzzle it is
    end if

    %resets the words
    for x : 1 .. 15     %resets the words done
	checkWord (x) := false     %resets the words done
    end for

    %Randomly outputs 1 of 3 puzzles with no repeats after completion
    if puzzleType = 1 then
	topic := "Animals" %puzzle topic

	%Letters for the animal word puzzle
	puzzleLetters :=
	    "COGECJUESZNFEGQTWHZYYJAZLCSIKIADFSUREEDSUTOSCCJEKNSXRNOSZSGHBHXRCOKAMOEFOLOFLYNFTNAQOWHDNVRUPKXNPYPNOLNYQGVQVOTJPLQIEBGRXOQEOTSAQRQLEFOHVDFPWQUUWXTGBCRDNXJOUXJRBOQOLPUDLNLVDJFAIWSGSHARKFVAOTLPJLJFAALSHXXFSJIPEQCVHIHUBFITBGOHE"

	drawfillbox (195, 65, 495, 362, gray) %Draws the box of the word search befire the letters

	%Draws the letters of the word search
	for x : 0 .. length (puzzleLetters) - 1
	    Font.Draw (puzzleLetters (x + 1), 200 + x mod 15 * 20, 350 - x div 15 * 20, font1, black) %Draws
	end for

	% Word bank for animals
	locate (3, 5)
	put topic, " Word Bank" ..

	for x : 1 .. 15
	    puzzleWords (x) := wordBank1 (x) %Stores the words for processing
	    locate (x + 4, 5)
	    put wordBank1 (x) .. %Puts the words
	end for

	%Locations of Words
	startingLetterX (1) := 7     %Ant
	startingLetterY (1) := 8     %Ant
	endingLetterX (1) := 5     %Ant
	endingLetterY (1) := 8     %Ant

	startingLetterX (2) := 13     %Bee
	startingLetterY (2) := 4     %Bee
	endingLetterX (2) := 11     %Bee
	endingLetterY (2) := 6     %Bee

	startingLetterX (3) := 0     %Cat
	startingLetterY (3) := 10     %Cat
	endingLetterX (3) := 0      %Cat
	endingLetterY (3) := 12     %Cat

	startingLetterX (4) := 14     %Cow
	startingLetterY (4) := 4     %Cow
	endingLetterX (4) := 12     %Cow
	endingLetterY (4) := 2     %Cow

	startingLetterX (5) := 8     %Deer
	startingLetterY (5) := 11     %Deer
	endingLetterX (5) := 5     %Deer
	endingLetterY (5) := 11     %Deer

	startingLetterX (6) := 2     %Dog
	startingLetterY (6) := 4     %Dog
	endingLetterX (6) := 0     %Dog
	endingLetterY (6) := 6     %Dog

	startingLetterX (7) := 11     %Fish
	startingLetterY (7) := 13     %Fish
	endingLetterX (7) := 14     %Fish
	endingLetterY (7) := 10     %Fish

	startingLetterX (8) := 0     %Fly
	startingLetterY (8) := 8     %Fly
	endingLetterX (8) := 2     %Fly
	endingLetterY (8) := 8     %Fly

	startingLetterX (9) := 4     %Fox
	startingLetterY (9) := 8     %Fox
	endingLetterX (9) := 6     %Fox
	endingLetterY (9) := 10     %Fox

	startingLetterX (10) := 12     %Goat
	startingLetterY (10) := 4     %Goat
	endingLetterX (10) := 9     %Goat
	endingLetterY (10) := 1     %Goat

	startingLetterX (11) := 8     %Mouse
	startingLetterY (11) := 9      %Mouse
	endingLetterX (11) := 12     %Mouse
	endingLetterY (11) := 13     %Mouse

	startingLetterX (12) := 9     %Owl
	startingLetterY (12) := 9     %Owl
	endingLetterX (12) := 11     %Owl
	endingLetterY (12) := 7     %Owl

	startingLetterX (13) := 11     %Pig
	startingLetterY (13) := 1     %Pig
	endingLetterX (13) := 11     %Pig
	endingLetterY (13) := -1     %Pig

	startingLetterX (14) := 0   %Shark
	startingLetterY (14) := 1  %Shark
	endingLetterX (14) := 4    %Shark
	endingLetterY (14) := 1  %Shark

	startingLetterX (15) := 5    %Wolf
	startingLetterY (15) := 4    %Wolf
	endingLetterX (15) := 5  %Wolf
	endingLetterY (15) := 1 %Wolf
    elsif puzzleType = 2 then
	topic := "Fruits" %puzzle topic

	%Letters for the fruits word puzzle
	puzzleLetters :=
	    "OGYMREZOBANANATXJJAGMDGDTDLQQUYHUNDKRAXAYEJCNGLAGYAVPRZCGWHOLRXOPAELPPAOLTCOIQEUGQUUNDBVROTTMGHMVCNDFIAACETWEFCNKFONMSYLVXVPCZAFBCOPEARCDREOPXEXIMPMVONHBBIACLPTELITBSOEGFCPLBWLUVWASPTRRSOXEVUMTGRTOCIRPAEBEQKKLEVFBMUYAVEEUZMBT"

	%Draws the box of the word search
	drawfillbox (195, 65, 495, 362, gray)

	%Draws the letters of the word search
	for x : 0 .. length (puzzleLetters) - 1
	    Font.Draw (puzzleLetters (x + 1), 200 + x mod 15 * 20, 350 - x div 15 * 20, font1, black)
	end for

	% Word bank for fruits
	locate (3, 5)
	put topic, " Word Bank" ..

	for x : 1 .. 15
	    locate (x + 4, 5)
	    put wordBank2 (x) .. %Puts the words
	    puzzleWords (x) := wordBank2 (x)  %Stores the words for processing
	end for

	%Locations of Words
	startingLetterX (1) := 10     %Apple
	startingLetterY (1) := 9     %Apple
	endingLetterX (1) := 6     %Apple
	endingLetterY (1) := 9     %Apple

	startingLetterX (2) := 6     %Apricot
	startingLetterY (2) := 0     %Apricot
	endingLetterX (2) := 0     %Apricot
	endingLetterY (2) := 0     %Apricot

	startingLetterX (3) := 13     %Avocado
	startingLetterY (3) := 7     %Avocado
	endingLetterX (3) := 7     %Avocado
	endingLetterY (3) := 13     %Avocado

	startingLetterX (4) := 8     %Banana
	startingLetterY (4) := 13     %Banana
	endingLetterX (4) := 13     %Banana
	endingLetterY (4) := 13     %Banana

	startingLetterX (5) := 0     %Cherry
	startingLetterY (5) := 4     %Cherry
	endingLetterX (5) := 5     %Cherry
	endingLetterY (5) := -1     %Cherry

	startingLetterX (6) := 14     %Coconut
	startingLetterY (6) := 7     %Coconut
	endingLetterX (6) := 14     %Coconut
	endingLetterY (6) := 13     %Coconut

	startingLetterX (7) := 7     %Grape
	startingLetterY (7) := 12     %Grape
	endingLetterX (7) := 3     %Grape
	endingLetterY (7) := 8     %Grape

	startingLetterX (8) := 3     %Guava
	startingLetterY (8) := 7     %Guava
	endingLetterX (8) := 7     %Guava
	endingLetterY (8) := 11     %Guava

	startingLetterX (9) := 10     %Lemon
	startingLetterY (9) := 2     %Lemon
	endingLetterX (9) := 10     %Lemon
	endingLetterY (9) := 6     %Lemon

	startingLetterX (10) := 0     %Lime
	startingLetterY (10) := 9     %Lime
	endingLetterX (10) := 3     %Lime
	endingLetterY (10) := 6     %Lime

	startingLetterX (11) := 3     %Mango
	startingLetterY (11) := 13     %Mango
	endingLetterX (11) := 3     %Mango
	endingLetterY (11) := 9     %Mango

	startingLetterX (12) := 0     %Orange
	startingLetterY (12) := 8     %Orange
	endingLetterX (12) := 5     %Orange
	endingLetterY (12) := 13     %Orange

	startingLetterX (13) := 8     %Peach
	startingLetterY (13) := 3     %Peach
	endingLetterX (13) := 4     %Peach
	endingLetterY (13) := 7     %Peach

	startingLetterX (14) := 11     %Pear
	startingLetterY (14) := 5     %Pear
	endingLetterX (14) := 14     %Pear
	endingLetterY (14) := 5     %Pear

	startingLetterX (15) := 11     %Plum
	startingLetterY (15) := 4     %Plum
	endingLetterX (15) := 11     %Plum
	endingLetterY (15) := 1     %Plum
    elsif puzzleType = 3 then
	topic := "Java"

	%Letters for the fruits word puzzle
	puzzleLetters :=
	    "LODYVPSVYKICLPZVVOIDMHLJTSSFAHOERHETYPECASTCJORFTEMDRBFZHYKSALHODQAHABAUSANDONRETEMARAPBGEDAVOIRMTGDIAAEWGDFOICHNBPQOPNMKINEPSIEUOSSALCANCOONRMNIOQVJIRGOYIELUWUTLFIHRLAADECGCMFGEZSPIHSUODRREYAQAEBCUHUVBAVKRLXCNEXZJBLDDMHKFAER"

	%Draws the box of the word search
	drawfillbox (195, 65, 495, 362, gray)

	%Draws the letters of the word search
	for x : 0 .. length (puzzleLetters) - 1
	    Font.Draw (puzzleLetters (x + 1), 200 + x mod 15 * 20, 350 - x div 15 * 20, font1, black)
	end for

	% Word bank for Java
	locate (3, 5)
	put topic, " Word Bank" ..

	for x : 1 .. 15
	    locate (x + 4, 5)
	    put wordBank3 (x) .. %Puts words
	    puzzleWords (x) := wordBank3 (x) %stores the words for processing
	end for

	%Locations of Words
	startingLetterX (1) := 7     %Argument
	startingLetterY (1) := 0     %Argument
	endingLetterX (1) := 7     %Argument
	endingLetterY (1) := 7     %Argument

	startingLetterX (2) := 6     %Body
	startingLetterY (2) := 0     %Body
	endingLetterX (2) := 3     %Body
	endingLetterY (2) := 3     %Body

	startingLetterX (3) := 8     %Boolean
	startingLetterY (3) := 6      %Boolean
	endingLetterX (3) := 14      %Boolean
	endingLetterY (3) := 0     %Boolean

	startingLetterX (4) := 1     %Chaining
	startingLetterY (4) := 0     %Chaining
	endingLetterX (4) := 8     %Chaining
	endingLetterY (4) := 7     %Chaining

	startingLetterX (5) := 14     %Class
	startingLetterY (5) := 5     %Class
	endingLetterX (5) := 10     %Class
	endingLetterY (5) := 5      %Class

	startingLetterX (6) := 11     %Flag
	startingLetterY (6) := -1     %Flag
	endingLetterX (6) := 11     %Flag
	endingLetterY (6) := 2     %Flag

	startingLetterX (7) := 10     %iteration
	startingLetterY (7) := 13     %iteration
	endingLetterX (7) := 2     %iteration
	endingLetterY (7) := 5     %iteration

	startingLetterX (8) := 1     %loop
	startingLetterY (8) := 2     %loop
	endingLetterX (8) := 4     %loop
	endingLetterY (8) := 5      %loop

	startingLetterX (9) := 5     %Method
	startingLetterY (9) := 12     %method
	endingLetterX (9) := 0     %Method
	endingLetterY (9) := 7     %method

	startingLetterX (10) := 1     %overloading
	startingLetterY (10) := 13     %overloading
	endingLetterX (10) := 1     %overloading
	endingLetterY (10) := 3     %overloading

	startingLetterX (11) := 13     %package
	startingLetterY (11) := 13     %package
	endingLetterX (11) := 13      %package
	endingLetterY (11) := 7     %package

	startingLetterX (12) := 11     %parameter
	startingLetterY (12) := 8     %parameter
	endingLetterX (12) := 3     %parameter
	endingLetterY (12) := 8     %parameter

	startingLetterX (13) := 10     %recursion
	startingLetterY (13) := 0     %recursion
	endingLetterX (13) := 2     %recursion
	endingLetterY (13) := 8     %recursion

	startingLetterX (14) := 5     %typecast
	startingLetterY (14) := 11     %typecast
	endingLetterX (14) := 12     %typecast
	endingLetterY (14) := 11     %typecast

	startingLetterX (15) := 1     %void
	startingLetterY (15) := 12     %void
	endingLetterX (15) := 4     %void
	endingLetterY (15) := 12     %void
    end if

    %User Inputs and Processing
    loop
	Mouse.Where (letterX, letterY, button)

	%If statement for if the user clicks within the word search box
	if button = 1 and (letterX > 200 and letterX < 492) and (letterY > 68 and letterY < 360) then

	    drawfillbox (195, 65, 495, 362, gray) %Draws the box of the word search and erases the boxes after each click

	    %If statement for the start letter input
	    if startLetter (1) = 0 then

		%Coordinates of the starting letter
		startLetter (1) := letterX - (letterX mod 20) % X-Coordinate
		startLetter (2) := letterY - (letterY mod 20)  % Y-Coordninate
		drawfillbox (startLetter (1) - 3, startLetter (2) + 5, startLetter (1) + 12, startLetter (2) + 20, white)     % Highlight Starting Letter Selection

	    else %The end letter input

		%Coordinates of the end letter
		endLetter (1) := letterX - (letterX mod 20) % X-Coordninate
		endLetter (2) := letterY - (letterY mod 20) % Y-Coordninate

		%If statemnt for Horizontal / Vertical Processing
		if not (startLetter (1) = endLetter (1) and startLetter (2) = endLetter (2)) and (endLetter (1) = startLetter (1) or endLetter (2) = startLetter (2)) then

		    Draw.ThickLine (startLetter (1) + 3, startLetter (2) + 15, endLetter (1) + 3, endLetter (2) + 15, 8, white) %Draws the line on the word
		    wordChecker     %Checks if a word is inputted
		end if

		%If statemnt for Diagonal Processing
		if abs (startLetter (1) - endLetter (1)) = abs (startLetter (2) - endLetter (2)) and not (startLetter (1) = endLetter (1) and startLetter (2) = endLetter (2)) then

		    % Left to Right Diagonal Processing
		    if startLetter (1) < endLetter (1) then

			%for loop to draw the boxes diagonally
			for x : startLetter (1) .. endLetter (1) %Left to right processing

			    %If statement for crossing the word out with a thick line on the left to right diagonal
			    if startLetter (2) > endLetter (2) then % First Selection is above Selection (downwards diagonal)
				Draw.ThickLine (x + 12, startLetter (2) - x + startLetter (1) + 5, x - 3, startLetter (2) - x + startLetter (1) + 20, 8, 0)
			    else          % First Selection is under the Selection (upwards Diagonal)
				Draw.ThickLine (x - 3, startLetter (2) + x - startLetter (1) + 5, x + 12, startLetter (2) + x - startLetter (1) + 20, 8, 0)
			    end if
			end for

		    else     % Right to Left Diagonal Processing

			%for loop to draw the boxes diagonally
			for x : endLetter (1) .. startLetter (1)

			    %If statement for crossing the word out with a thick line on the right to left diagonal
			    if endLetter (2) > startLetter (2) then     % Start letter is under end letter (Upwards Diagonal)
				Draw.ThickLine (x + 12, endLetter (2) - x + endLetter (1) + 5, x - 3, endLetter (2) - x + endLetter (1) + 20, 8, 0) %Draws the blue boxes
			    else     %Start letter is above end letter  (Downwards Diagonal)
				Draw.ThickLine (x - 3, endLetter (2) + x - endLetter (1) + 5, x + 12, endLetter (2) + x - endLetter (1) + 20, 8, 0) %draws the blue boxes
			    end if
			end for
		    end if
		    wordChecker %Checks if a word is inputted
		end if

		% Reset Selection Coords for Next Word Selection
		startLetter (1) := 0
		endLetter (1) := 0
		startLetter (2) := 0
		endLetter (2) := 0
	    end if

	    %Draws the letters of the word search on top of the gray outline
	    for x : 0 .. length (puzzleLetters) - 1
		Font.Draw (puzzleLetters (x + 1), 200 + x mod 15 * 20, 350 - x div 15 * 20, font1, black) %Draws the letters
	    end for

	    %Refreshes mouse
	    loop
		mousewhere (letterX, letterY, button)
		exit when button = 0
	    end loop

	    %Crosses out words
	    for x : 1 .. 15     %Processes the 15 words
		if checkWord (x) = true then     % Checks if user got a word
		    drawline (28, 343 - (16 * x), 35 + (length (puzzleWords (x)) * 8), 343 - (16 * x), 255)     %Crosses out the word the user got right
		end if
	    end for

	    View.Update %Stops flashing
	end if

	%Timer
	loopTimeElapsed := Time.Elapsed %Time.Elapsed for when the loop started

	%if statement to start the timer
	if realUserTime > 0 then
	    timerChecker := true %Starts timer
	end if

	%If statement for the timer
	if timerChecker = true then
	    locate (2, 73)
	    put "Timer"
	    View.Update %Stops flashing

	    %If statement for the timer processing
	    if (loopTimeElapsed - programTimeElapsed >= 1000) then
		realUserTime := realUserTime - 1 %Counts down
		locate (3, 75)
		put realUserTime + 1 %Makes up for the 1 second lost in the processing
		View.Update %Stops flashing
		programTimeElapsed := loopTimeElapsed
	    end if

	    %For if the user runs out of time
	    if realUserTime < 0 then
		winChecker := false
		exitLoop := true
	    end if
	end if

	%For if the user clicks on the main menu button to exit
	if button = 1 and (letterX >= 270 and letterX <= 370) and (letterY >= 5 and letterY <= 20) then
	    menuExitLoop := true
	elsif puzzleNumber > 3 then %if the user wins
	    winChecker := true
	end if

	exit when winChecker = true or exitLoop = true or menuExitLoop = true %If the user runs out of time or clicks on the main menu button or wins
    end loop

    %If statement for what the program does after exititng the loop
    if realUserTime <= 0 and timerChecker = true then     %if the user runs out of time
	winChecker := false %The user loses
	display %Calls display to show "you lose"
    elsif winChecker = true then
	display %Calls display to show "you win"
    elsif menuExitLoop = true then %If the user clicks on the main menu btn
	mainMenu %Calls main menu
    end if
end userInput

%Program display - Outputs whether the user wins or loses
body procedure display
    title

    %Sets up buttons
    GUI.Show (mainMenuBtn)

    %If statement for determining if the user wins
    if winChecker = false then     %If the user loses
	fork failMusic
	locate (5, 36)
	put "You Lose!"
    else     %If the user wins
	fork winMusic
	locate (5, 36)
	put "You Win!"
    end if

    winChecker := false %resets user wins
end display

%Program goodbye
procedure goodbye
    title     %Calls title
    locate (11, 32)
    put "Thanks for Playing!"     %Prints goodbye
    locate (12, 35)
    put "By: Jerry Zhu"     %Prints my name

    delay (1000)     %1 Second to close
    Window.Close (mainWindow)     %closes window
end goodbye

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End Procedures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Main Program
intro
loop
    exit when GUI.ProcessEvent
end loop
goodbye
%End Program
