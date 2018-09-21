extends Node2D

var player1
var player2
const Player = preload("res://src/main/Player.gd")

func _ready():
	player1 = Player.new("x", $X_Sound)
	player2 = Player.new("o", $O_Sound)
	
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$Board.connect("played_turn", self, "switch_player_turns")
	$Board.connect("board_match", self, "game_won")
	
func start_game():
	$Board.reset_board()
	$Board.set_controller(player1)
	$Board.visible = true
	$Background_Music.play()

func game_won():
	$Board.visible = false
	$HUD.show_message("Someone won")
	$Background_Music.stop()

func switch_player_turns():
	var controller = $Board.get_controller()
	if controller.id == player1.id:
		$Board.set_controller(player2)
	else:
		$Board.set_controller(player1)