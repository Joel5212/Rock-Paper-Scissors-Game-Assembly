# Jeremiah Garcia, Joel Joshy, Ryan Phan,
# Jibriel Ustarz, Hailee Wheat - Rock, Paper, Scissors Game
#
# This program is a basic Rock, Paper, Scissors (RPS) game. 
# It allows a user to play RPS with a CPU or with a second player.


.data

ProjectName: 	.asciiz "Rock, Paper, and Scissor Game Project\n"
Creators: 	.asciiz "Created by: Joel Joshy, Jeremiah Garcia, Jibriel Ustarz, Hailee Wheat, Ryan Phan\n"
ForClass: 	.asciiz "For CS2640 of Spring 2022\n"

welcome: 	.asciiz "\nWelcome to Rock Paper Scissors. Here are the rules to the game.\n"

twoPlayers: 	.asciiz "\nThere are two players. You and the computer/other player."
select: 	.asciiz "\nSelect a choice between Rock, Paper, or Scissors.\n"

outcomes: 	.asciiz "\nRock beats Paper, Paper beats Rock, and Scissors beat Paper"
winConditions: 	.asciiz "\nIf you win 3 times, then you win the game overall.\n"

wantToPlay: 	.asciiz "\nWould you like to play the game? (y or n) "

playerCount:	.asciiz "\nAre you playing with a friend or with the computer? (f or c) "

enterChoice: 	.asciiz "\nPlease enter your choice."
rock: 		.asciiz "\nRock (r)"
paper: 		.asciiz "\nPaper (p)"
scissor: 	.asciiz "\nScissors (s)"
quit:		.asciiz "\nQuit Game (q)"
askUserChoice: 	.asciiz "\nPlayer 1: What is your choice? "
# These are used to hide the first players choice
nL:		.asciiz "\n"
one:		.asciiz "r\n"
two:		.asciiz "p\nr\n"
three:		.asciiz "s\nr\np\n"
four:		.asciiz "p\ns\nr\ns\n"
five:		.asciiz "r\np\ns\nr\np\n"
#
askUser2Choice: .asciiz "\nPlayer 2: What is your choice? "

playAgain:      .asciiz "\n\nDo you want to play again? (y or n) "
endlessPlay:	.asciiz "\n\nDo you want to play endlessmode? (y or n) "

userChoice:	.asciiz "\nPlayer 1 chose: "
user2Choice:	.asciiz " and Player 2 chose: "
computerChoice: .asciiz " and the computer chose: "

youWin: 	.asciiz " so...\n\nYou won! :)"
youLose: 	.asciiz " so...\n\nYou lost. :("
youTied:	.asciiz " so...\n\nYou tied with the CPU. :|"
player1Won:	.asciiz " so...\n\nPlayer 1 won this round! :)"
player2Won:	.asciiz " so...\n\nPlayer 2 won this round! :)"
playersTied:	.asciiz " so...\n\nYou both tied. :|"

ending: 	.asciiz "\nEnding the game and exiting the program."
round:	 	.asciiz "\n\n\nRound "
colon: 		.asciiz ":"
scoreboard1:    .asciiz "\n=================*SCOREBOARD*==================\n"		
scoreboardSpace:.asciiz "               "			     
scoreboard2:	.asciiz "\n===============================================\n\n"
    
player1Score:   .asciiz "   Player 1: "
player2Score:   .asciiz "   Player 2: "

yourScore:      .asciiz "   My Score: "
cpuScore:       .asciiz "   CPU Score: "

p1WinsMsg:	.asciiz "Player 1 Wins!!!"
p2WinsMsg:	.asciiz "Player 2 Wins!!!"
cpuWinsMsg:	.asciiz "You Lost!!!"

#User Validation
errorMessage: 	.asciiz "\nPlease enter a valid choice!\n"

.text
main:
	#Displaying the introduction (what is this program and who made it)
	la $a0, ProjectName
	li $v0, 4
	syscall
	
	la $a0, Creators
	li $v0, 4
	syscall
	
	la $a0, ForClass
	li $v0, 4
	syscall

	# Displaying the welcome message
	la $a0, welcome
	li $v0, 4
	syscall
	
	# Message 2-5 displays the rules of the game
	la $a0, twoPlayers
	li $v0, 4
	syscall
	
	la $a0, select
	li $v0, 4
	syscall
	
	la $a0, outcomes
	li $v0, 4
	syscall
	
	la $a0, winConditions
	li $v0, 4
	syscall
	
	playGameValidation:	#Validation
	# Asking the player if they want to play the game or not
	la $a0, wantToPlay
	li $v0, 4
	syscall
	
	#Getting user response
	li $v0, 12
	syscall
	beq $v0, 'n', exit
	beq $v0, 'y', playGameTrue
	
	#Display error message if user did not enter a valid choice
	la $a0, errorMessage
	li $v0, 4
	syscall
	
	j playGameValidation #jump to the beginning if the user did not enter a valid answer
	
	playGameTrue:
		
	# Set round counter to 0
	add $s4, $zero, $zero			# Round counter is in $s4

	gamemodeValidation:
	# Ask the player if they are going to play pvp or cpu
	la $a0, playerCount
	li $v0, 4
	syscall

	li $v0, 12
	syscall
	beq $v0, 'f', PVPTrue
	beq $v0, 'c', PVETrue
	
	#Display error message if user did not enter a valid choice
	la $a0, errorMessage
	li $v0, 4
	syscall
	
	j gamemodeValidation
	
	PVETrue:
	
	#Player  Score/ Player1
	add $s2, $zero, $zero
	#CPU Score/ Player 
	add $s3, $zero, $zero

	# PVP false
		add $s7, $zero, $zero
		j game

	PVPTrue:
		addi $s7, $zero, 1		# PVP or CPU is in $s7
	
	#endless mode off
	li $s6, 0
	j game

	endlessModeOn:
		li $s6, 1

game:
	# Telling the user what the choices are, should they accept to play the game
	la $a0, enterChoice
	li $v0, 4
	syscall

	la $a0, rock
	li $v0, 4
	syscall

	la $a0, paper
	li $v0, 4
	syscall

	la $a0, scissor
	li $v0, 4
	syscall
	
	bne $s6, 1, notEndless	#Display the quit message only when it is in endless mode
	la $a0, quit
	li $v0, 4
	syscall
	
	notEndless:
	la $a0, askUserChoice
	li $v0, 4
	syscall

	# Check if it is PVP or CPU
	beq $s7, $zero, userInput
	la $a0, nL
	li $v0, 4
	syscall
	jal randomLetters

	userInput:
		# User input choice
		li $v0, 12
		syscall
		
		#Validation, if true skips the validation process.
		beq $v0, 'r', userInputTrue
		beq $v0, 'p', userInputTrue
		beq $v0, 's', userInputTrue
		
		bne $s6, 1, skipQuit
		beq $v0, 'q', exit
		
		skipQuit:
		#Display error message if user did not enter a valid choice
		la $a0, errorMessage
		li $v0, 4
		syscall
		
		j notEndless	#jump back so user can input a valid choice
		
		userInputTrue:
		move $s0, $v0 				# user choice is in $s0
		
		# Check if it is PVP or CPU
		beq $s7, $zero, CPUChoice
		la $a0, nL
		li $v0, 4
		syscall
		jal randomLetters
		
		user2Input:
		la $a0, askUser2Choice
		li $v0, 4
		syscall

		# User input choice
		li $v0, 12
		syscall
		
		beq $v0, 'r', user2InputTrue
		beq $v0, 'p', user2InputTrue
		beq $v0, 's', user2InputTrue
		
		bne $s6, 1, skipQuitPlayer2
		beq $v0, 'q', exit
		
		skipQuitPlayer2:
		
		#Display error message if user did not enter a valid choice
		la $a0, errorMessage
		li $v0, 4
		syscall
		
		j user2Input
		
		user2InputTrue:
		move $s1, $v0 				# second user choice is in $s1

		j choices

	CPUChoice:
		# Computer Choice
		li $a1, 3				# this is to set the upper limit (in this case the limit is at 3)
		li $v0, 42				# syscall to create the random number
		syscall					# returns the random number at $a0
		addi $s1, $a0, 1			# numerical computer choice is in $s1

		# Convert computer choice to character
		beq $s1, 1, computerChoseRock
		beq $s1, 2, computerChosePaper
		beq $s1, 3, computerChoseScissors

	computerChoseRock:
		li $s1, 'r'
		j choices

	computerChosePaper:
		li $s1, 'p'
		j choices

	computerChoseScissors:
		li $s1, 's'
		j choices

choices:
	# Displays users choice
	la $a0, userChoice
	li $v0, 4
	syscall
	la $a0, ($s0)
	li $v0, 11
	syscall

	# Check if it is PVP or CPU
	beq $s7, $zero, CPUDisplay

	la $a0, user2Choice
	li $v0, 4
	syscall
	la $a0, ($s1)
	li $v0, 11
	syscall

	j compare

	CPUDisplay:
		# Displays computer's choice 
		la $a0, computerChoice	
		li $v0, 4
		syscall
		la $a0, ($s1)
		li $v0, 11
		syscall
	
compare:
	# Compare user and computer's/second player's choice
	beq $s0, $s1, tie
	beq $s0, 'r', choseRock
	beq $s0, 'p', chosePaper
	beq $s0, 's', choseScissors
					
	# Player 1 chose rock
	choseRock:		
		# Check if User beat CPU/player
		beq $s1, 's', player1Wins
		j player1Loses
		
	# Player 1 chose paper
	chosePaper:
		# Check if User beat CPU/player
		beq $s1, 'r', player1Wins
		j player1Loses
		
	# Player 1 chose scissors
	choseScissors:
		# Check if User beat CPU/player
		beq $s1, 'p', player1Wins
		j player1Loses

	# Player 1 chose same option as CPU/player
	tie:
		# Displays tie message
		beq $s7, $zero, CPUTie
		la $a0, playersTied
		j printResult
		

		CPUTie:
			la $a0, youTied	
			j printResult

	player1Wins:
		# Increase Player 1's score
		addi $s2, $s2, 1
		
		
		# Displays winning message
		beq $s7, $zero, CPULoses
		la $a0, player1Won
		j printResult

		CPULoses:
			la $a0, youWin				
			j printResult
	
	player1Loses:
		# Increase CPU's/Player 2's score
		addi $s3, $s3, 1
		
		
		# Displays losing message
		beq $s7, $zero, CPUWins
		la $a0, player2Won
		j printResult

		CPUWins:
			la $a0, youLose		
			j printResult

	printResult:
		li $v0, 4
		syscall
	jal roundCounter
	jal scoreboard
	j endRound

endRound:
	# Check if it is in endless mode
	beq $s6, 1, game
	
	# Check score to see if game needs to end
	beq $s2, 3, p1Wins
	beq $s3, 3, p1Loses
	j game

	p1Wins:
		la $a0, p1WinsMsg
		j printWins

	p1Loses:
		beq $s7, 1, p2Wins
		la $a0, cpuWinsMsg
		j printWins
	
	p2Wins:
		la $a0, p2WinsMsg
	
	printWins:	
		li $v0, 4
		syscall

endlessValidation:
	la $a0, endlessPlay
	li $v0, 4
	syscall
	
	# get user choice
	li $v0, 12                              
	syscall
	
	# if the value in register $v0 equals 'y' then the program will go to label game but if the value is 'n' then the program will end
	beq $v0, 'y', endlessModeOn
	beq $v0, 'n', exit
	
	#Error message if they don't choose y or n
	la $a0, errorMessage
	li $v0, 4
	syscall
	
	j endlessValidation
	
roundCounter:
	# add 1 to round counter
	addi $s4, $s4, 1
	
	la $a0, round
 	li $v0, 4
 	syscall
 	
 	li  $v0, 1
 	move $a0, $s4
 	syscall
 	
 	la $a0, colon
 	li $v0, 4
 	syscall
 
 	jr $ra
	
scoreboard:
	beq $s7, $zero, scoreboardCPU
	
	la $a0, scoreboard1
 	li $v0, 4
 	syscall
 	
 	la $a0, player1Score
 	li $v0, 4
 	syscall
 	
 	li  $v0, 1
 	move $a0, $s2
 	syscall
 	
 	la $a0, scoreboardSpace
 	li $v0, 4
 	syscall
 	
 	la $a0, player2Score
 	li $v0, 4
 	syscall
 	
 	li  $v0, 1
 	move $a0, $s3
 	syscall
 	
 	
 	la $a0, scoreboard2
 	li $v0, 4
 	syscall
 	
 	jr $ra
 	
scoreboardCPU:
 	la $a0, scoreboard1
 	li $v0, 4
 	syscall
 	
 	la $a0, yourScore
 	li $v0, 4
 	syscall
 	
 	li  $v0, 1
 	move $a0, $s2
 	syscall
 	
 	la $a0, scoreboardSpace
 	li $v0, 4
 	syscall
 	
 	la $a0, cpuScore
 	li $v0, 4
 	syscall
 	
 	li  $v0, 1
 	move $a0, $s3
 	syscall

 	la $a0, scoreboard2
 	li $v0, 4
 	syscall
 	
 	jr $ra

randomLetters:
	li $a1, 6
	li $v0, 42
	syscall		

	beq $a0, 0, rlEnd
	beq $a0, 1, loadOne
	beq $a0, 2, loadTwo
	beq $a0, 3, loadThree
	beq $a0, 4, loadFour
	beq $a0, 5, loadFive

	loadOne:
		la $a0, one
		j rlPrint
	loadTwo:
		la $a0, two
		j rlPrint
	loadThree:
		la $a0, three
		j rlPrint
	loadFour:
		la $a0, four
		j rlPrint
	loadFive:
		la $a0, five
		j rlPrint

	rlPrint:
		li $v0, 4
		syscall

	rlEnd:
		jr $ra

exit:
	# Ending the program, displaying an exit message
	la $a0, ending
	li $v0, 4
	syscall

	li $v0, 10
	syscall
