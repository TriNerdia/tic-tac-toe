extends Node2D

signal played_turn

# This person has control over the entire board for the turn
var _controller = ""

func _ready():
	# Setting the pressed event on all the buttons on the board
	for i in $Buttons.get_child_count():
		var button = $Buttons.get_child(i)
		button.connect("pressed", self, "button_pressed", [button])
		
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