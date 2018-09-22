# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

var player1
var player2
const Player = preload("res://src/main/Player.gd")

# AI Variables
const CPU = preload("res://src/main/CPU.gd")
var cpu_on = false
signal CPU_Turn

func _ready():
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$Board.connect("turn_played", self, "switch_player_turns")
	$Board.connect("board_matched", self, "game_won")
	$Board.connect("board_tied", self, "game_tied")
	
func start_game():
	player1 = Player.new("x", $X_Sound)
	if cpu_on:
		player2 = CPU.new("o", $O_Sound, 0)
	else:
		player2 = Player.new("o", $O_Sound)
	
	$Board.reset_board()
	$Board.set_controller(player1)
	$Board.visible = true
	$Background_Music.play()

func game_won(player):
	$HUD.show_message(player.id + " won!")
	$Background_Music.stop()
	
func game_tied():
	$HUD.show_message("Game was tied.")
	$Background_Music.stop()

func switch_player_turns():
	var controller = $Board.get_controller()
	if controller.id == player1.id:
		$Board.set_controller(player2)
	else:
		$Board.set_controller(player1)
	if $Board.get_controller().isType("CPU"):
		emit_signal("CPU_Turn")

func _on_HUD_CPU_On_Off():
	cpu_on = !cpu_on
