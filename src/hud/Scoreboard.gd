# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

var _highlight_color = "eff163"

func _ready():
	$Player1/Value.text = "0"
	$Player2/Value.text = "0"
	$Tie/Value.text = "0"

func highlight_board_controller(id):
	if id == $Player1/Key.text:
		$Player1/Key.add_color_override("font_color", Color(_highlight_color))
		$Player1/Value.add_color_override("font_color", Color(_highlight_color))
	elif id == $Player2/Key.text:
		$Player2/Key.add_color_override("font_color", Color(_highlight_color))
		$Player2/Value.add_color_override("font_color", Color(_highlight_color))

func _set_score(label, score):
	assert label is Label
	assert typeof(score) == TYPE_INT
	label.text = str(score)
	
# Player1 Functions
func set_player1_score(score):
	_set_score($Player1/Value, score)
	
func set_player1_name(name):
	$Player1/Key.text = str(name)
	
# Tie Functions
func set_tie_score(score):
	_set_score($Tie/Value, score)
	
# Player2 Functions
func set_player2_score(score):
	_set_score($Player2/Value, score)
	
func set_player2_name(name):
	$Player2/Key.text = str(name)