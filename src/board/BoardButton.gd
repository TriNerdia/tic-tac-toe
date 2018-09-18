extends Button

#signal set_state(buttonText)

#func _pressed():
#	emit_signal("set_state")


func _ready():
	self.text = " "
	var Board = get_node("/root/Board")
	self.connect("pressed",Board,"button_pressed",[self])