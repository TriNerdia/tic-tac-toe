extends Node2D

var player1
var player2
const player_class = preload("res://src/main/Player.gd")

func _ready():
	player1 = player_class.new("x")
	player2 = player_class.new("o")
	
	# Connecting signals
	$HUD.connect("start_game", self, "start_game")
	$Board.connect("played_turn", self, "switch_player_turns")
	$Board.connect("board_match", self, "game_won")
	
func start_game():
	$Board.reset_board()
	$Board.set_controller(player1.get_id())
	$Board.visible = true

func game_won():
	$Board.visible = false
	$HUD.show_message("Someone won")

func switch_player_turns():
	var controller = $Board.get_controller()
	if controller == player1.get_id():
		$Board.set_controller(player2.get_id())
	else:
		$Board.set_controller(player1.get_id())