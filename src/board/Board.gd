# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

signal turn_played
signal board_match

# Type: Player
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
		
func set_controller(player):
	_controller = player
	
func get_controller():
	return _controller

func button_pressed(button):		
	# simple check to not override a button that has already
	# been pressed
	if button.text == "":
		button.text = _controller.id
		_controller.play_sound()
		emit_signal("turn_played")
		
	if _check_board_for_win():
		return emit_signal("board_match")