extends CanvasLayer

signal start_game

func _ready():
	$StartBtn.connect("pressed", self, "start_button_pressed")

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$StartBtn.show()
	
func start_button_pressed():
	$StartBtn.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
