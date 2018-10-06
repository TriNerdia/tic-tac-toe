extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal return_mm

func _ready():
	$BackBtn.connect("pressed", self, "return_mainmenu")

func return_mainmenu():
	emit_signal("return_mm")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
