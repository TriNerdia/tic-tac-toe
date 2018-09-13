extends Button

signal set_state(buttonText)

func _pressed():
	emit_signal("set_state")