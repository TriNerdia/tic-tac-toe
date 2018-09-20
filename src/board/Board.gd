extends Node2D

signal played_turn
signal board_match

# This person has control over the entire board for the turn
var _controller = ""

var _match_patterns = [
	# rows
	[0,1,2],[3,4,5],[6,7,8],
	
	# columns
	[0,3,6],[1,4,7],[2,5,8],
	
	# diagnals
	[0,4,8],[6,4,2]
]

func _ready():
	# Setting the pressed event on all the buttons on the board
	for i in $Buttons.get_child_count():
		var button = $Buttons.get_child(i)
		button.connect("pressed", self, "button_pressed", [button])

func reset_board():
	for i in $Buttons.get_child_count():
		$Buttons.get_child(i).text = ""
		
func _check_board_for_win():
	for section in _match_patterns:
		var button1 = $Buttons.get_child(section[0])
		var button2 = $Buttons.get_child(section[1])
		var button3 = $Buttons.get_child(section[2])
		
		if button1.text == "" and button2.text == "" and button3.text == "":
			continue
		
		if button1.text == button2.text and button2.text == button3.text and button1.text == button3.text:
			return true	
	return false
		
func set_controller(player_id):
	_controller = str(player_id)
	
func get_controller():
	return _controller

func button_pressed(button):		
	# simple check to not override a button that has already
	# been pressed
	if button.text == "":
		button.text = _controller
		emit_signal("played_turn")
		
	if _check_board_for_win():
		return emit_signal("board_match")