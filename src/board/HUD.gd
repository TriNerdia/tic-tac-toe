extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$StartBtn.show()
	


func _on_StartBtn_pressed():
	$StartBtn.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
