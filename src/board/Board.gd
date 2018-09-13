extends Node2D

func _ready():
	$BoardButton.connect("set_state", self, "button_pressed", [$BoardButton.text])
	
func button_pressed(buttonText):
	buttonText = "x"