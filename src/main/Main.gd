# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node2D

var player1
var player2
const Player = preload("res://src/main/Player.gd")
export(String, FILE, "*.tscn") var Setting_loc

func _ready():
	player1 = Player.new("x", $X_Sound)
	player2 = Player.new("o", $O_Sound)
	
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$HUD.connect("goto_settings",self,"open_settings")
	$Settings.connect("update_Settings", self, "update_settings")
	$Board.connect("turn_played", self, "switch_player_turns")
	$Board.connect("board_matched", self, "game_won")
	$Board.connect("board_tied", self, "game_tied")
	
func update_settings(vol_music,vol_sound,cpu_level):
	$HUD.show_message("Tic-Tac-Toe")
	$Settings.visible = false
	print(str(vol_music) + " " + str(vol_sound) + " " + str(cpu_level))
	$Background_Music.volume_db = vol_music
	$X_Sound.volume_db = vol_sound
	$O_Sound.volume_db = vol_sound
	print(str($Background_Music.volume_db) + " " + str($X_Sound.volume_db) + " " + str($O_Sound.volume_db))
	
func open_settings():
	$Settings.visible = true
	
func start_game():
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