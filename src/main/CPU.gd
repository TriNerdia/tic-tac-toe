# Copyright (c) 2018 TriNerdia
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends "res://src/main/Player.gd"

# Custom Signals

# Variables
# How strong is CPU - Easy, 0 - Normal, 1
var level

# Godot Engine Functions
func _init(cpu_id, cpu_sound, cpu_lv).(cpu_id,cpu_sound):
	_set_cpu_lv(cpu_lv)

# Local Functions
	
func isType(type):
	return "CPU" == type
	
func _set_cpu_lv(cpu_lv):
	level = cpu_lv
	
func get_cpu_lv():
	return level
	
func match_two_winning(board, winning_patterns):
	for section in winning_patterns:
		var button1 = board[section[0]]
		var button2 = board[section[1]]
		var button3 = board[section[2]]
		
		if button2 != "" && button2 == button3:
			if button1 == "":
				return section[0]
		if button1 != "" && button1 == button3:
			if button2 == "":
				return section[1]
		if button1 != "" && button1 == button2:
			if button3 == "":
				return section[2]
	return -1
	
func CPU_Turn(board, playable_spots, winning_patterns):
	var picked_spot = -1
	if playable_spots == []:
		return picked_spot
	else:
		if level == 1:
			picked_spot = match_two_winning(board, winning_patterns)
		if picked_spot == -1:
			return playable_spots[rand_range(0,len(playable_spots))]
		else:
			return picked_spot
		

