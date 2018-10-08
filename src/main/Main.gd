# Copyright (c) 2018 TriNerdia
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

# Custom Signals

# Variables
var player1
var player2
const Player = preload("res://src/main/Player.gd")

const CPU = preload("res://src/main/CPU.gd")
var cpu_on = false
var cpu_level = 0

# Godot Engine Functions
func _ready():
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$Board.connect("turn_played", self, "switch_player_turns")
	$Board.connect("board_matched", self, "game_won")
	$Board.connect("board_tied", self, "game_tied")
	randomize()

# Local Functions	
func start_game():
	player1 = Player.new("x", $X_Sound)
	if cpu_on:
		player2 = CPU.new("o", $O_Sound, cpu_level)
	else:
		player2 = Player.new("o", $O_Sound)
	
	$Board.reset_board()
	$Board.set_controller(player1)
	$Board.visible = true
	$Background_Music.play()
	$CPU_Timer.stop()

func game_won(player):
	$HUD.show_message(player.id + " won!")
	$Background_Music.stop()
	$CPU_Timer.stop()
	
func game_tied():
	$HUD.show_message("Game was tied.")
	$Background_Music.stop()
	$CPU_Timer.stop()

func switch_player_turns():
	var controller = $Board.get_controller()
	if controller.id == player1.id:
		$Board.set_controller(player2)
	else:
		$Board.set_controller(player1)
	if $Board.get_controller().isType("CPU"):
		$Board._disable_board()
		$CPU_Timer.start()
		

func _on_CPU_Timer_timeout():
	$Board._enable_board()
	$Board.press_button(
	$Board.get_controller().CPU_Turn(
	$Board._get_board(), $Board.get_blank_buttons(),$Board._get_matching_patterns()))

func _on_HUD_CPU_On_Off():
	cpu_on = !cpu_on


func _on_HUD_CPU_Lvl(Level):
	cpu_level = Level
