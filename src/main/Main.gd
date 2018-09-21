# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

var player1
var player2
const Player = preload("res://src/main/Player.gd")

func _ready():
	player1 = Player.new("x", $X_Sound)
	player2 = Player.new("o", $O_Sound)
	
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$Board.connect("turn_played", self, "switch_player_turns")
	$Board.connect("board_matched", self, "game_won")
	$Board.connect("board_tied", self, "game_tied")
	
func start_game():
	$Board.reset_board()
	$Board.set_controller(player1)
	$Board.visible = true
	$Background_Music.play()

func game_won(player):
	$Board.visible = false
	$HUD.show_message(player.id + " won!!")
	$Background_Music.stop()
	
func game_tied():
	$Board.visible = false
	$HUD.show_message("Game was tied.")
	$Background_Music.stop()

func switch_player_turns():
	var controller = $Board.get_controller()
	if controller.id == player1.id:
		$Board.set_controller(player2)
	else:
		$Board.set_controller(player1)