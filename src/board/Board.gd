extends Node2D



var p1_turn = true
var gameboard = [0,0,0,0,0,0,0,0,0]

func _ready():
	$Background.visible = false
	var count = 1
	while count < 10:
		get_node("BoardButton"+str(count)).visible = false
		count = count + 1
	# $BG_Music.play()
	#$BoardButton.connect("set_state", self, "button_pressed", [$BoardButton.text])

func compare_index(indx1, indx2, indx3):
	if gameboard[indx1] == 0||gameboard[indx2]==0||gameboard[indx3]==0:
		return false
	elif gameboard[indx1] == gameboard[indx2] && gameboard[indx1] == gameboard[indx3]:
		return true
	else:
		return false

func game_over():
	#Rows
	if compare_index(0,1,2):
		return true
	elif compare_index(3,4,5):
		return true
	elif compare_index(6,7,8):
		return true
	#Columns
	elif compare_index(0,3,6):
		return true
	elif compare_index(1,4,7):
		return true
	elif compare_index(2,5,8):
		return true
	#Diagnals
	elif compare_index(0,4,8):
		return true
	elif compare_index(2,4,6):
		return true
	#No Matches
	else:
		return false

func game_tie():
	for indx in gameboard:
		if indx == 0:
			return false
	return true

# This receives the signal from button pressed
# Pressed_button is the object button that was pressed
func button_pressed(Pressed_button):
	if Pressed_button.text == " ":
		if p1_turn:
			Pressed_button.text = "X"
			gameboard[int(Pressed_button.name[11])-1] = 1
			$X_Sound.play()
		else:
			Pressed_button.text = "O"
			gameboard[int(Pressed_button.name[11])-1] = 2
			$O_Sound.play()
		if game_over():
			if p1_turn:
				print("Player 1 Wins")
			else:
				print("Player 2 Wins")
		elif game_tie():
			print("Game is a tie")
		p1_turn = !p1_turn
		print(gameboard)
		Pressed_button.set_disabled(true)



func _on_HUD_start_game():
	$Background.visible = true
	var count = 1
	while count < 10:
		get_node("BoardButton"+str(count)).visible = true
		count = count + 1
