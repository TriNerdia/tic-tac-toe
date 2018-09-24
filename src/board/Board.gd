# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

signal turn_played
signal board_matched(player)
signal board_tied

# Type: Player
var _prev_controller = null
var _controller = null

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
		$Buttons.get_child(i).disabled = false

func _disable_board():
	for i in $Buttons.get_child_count():
		$Buttons.get_child(i).disabled = true

func _check_board_for_win():
	for section in _match_patterns:
		var button1 = $Buttons.get_child(section[0])
		var button2 = $Buttons.get_child(section[1])
		var button3 = $Buttons.get_child(section[2])
		
		if button1.text == "" and button2.text == "" and button3.text == "":
			continue
		
		if button1.text == button2.text and button2.text == button3.text:
			return true	
	return false
	
func _check_board_for_tie():
	var count = 0
	for button_id in $Buttons.get_child_count():
		if $Buttons.get_child(button_id).text != "":
			count += 1
	
	if count == 9:
		return true
	return false
		
func set_controller(player):
	_prev_controller = _controller
	_controller = player
	
func get_controller():
    return _controller
    
func press_button(button_id):
    assert typeof(button_id) == TYPE_INT
    if button_id >= 0 and button_id < $Buttons.get_child_count(): 
        button_pressed($Buttons.get_child(button_id))
        return true
    return false

func get_blank_buttons():
    var free_spots = []
    for i in $Buttons.get_child_count():
        if $Buttons.get_child(i).text == "":
            free_spots.append(i)
    return free_spots

func _on_World_CPU_Turn():
    var playable_spots = get_blank_buttons()
    if playable_spots == []:
        return
    $Buttons.get_child(playable_spots[rand_range(0,len(playable_spots))]).text = _controller.id
    _controller.play_sound()
    emit_signal("played_turn")
    
    if _check_board_for_win():
        return emit_signal("board_match")

func button_pressed(button):		
	# simple check to not override a button that has already
	# been pressed
	if button.text == "":
		button.text = _controller.id
		_controller.play_sound()
		emit_signal("turn_played")
		
	if _check_board_for_win():
		# the reason the previous controller is returned is that
		# by the time the code reaches this point, the controller 
		# of the board will have already been changed.
		_disable_board()
		return emit_signal("board_matched", _prev_controller)
		
	elif _check_board_for_tie():
		_disable_board()
        return emit_signal("board_tied")
