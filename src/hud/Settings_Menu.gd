extends Control

signal return_mm(vol_master,vol_music,vol_sound,CPU_level)

func _ready():
	$Header/btn_Menu.connect("pressed", self, "return_mm")

func return_mm():
	emit_signal("return_mm",
	$Sliders/Vol_Master/sld_Master.value,
	$Sliders/Vol_Music/sld_Music.value,
	$Sliders/Vol_Sound/sld_Sound.value,
	$Sliders/CPU_Level/sld_CPU_Level.value)
