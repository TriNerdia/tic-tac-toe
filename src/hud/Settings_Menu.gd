extends Control

signal update_Settings(vol_music,vol_sound,CPU_level)

func _ready():
	$Header/btn_Menu.connect("pressed", self, "return_mm")

func return_mm():
	var sound_volume = 40*($Sliders/Vol_Sound/sld_Sound.value)*($Sliders/Vol_Master/sld_Master.value)-40
	var music_volume = 30*($Sliders/Vol_Music/sld_Music.value)*($Sliders/Vol_Master/sld_Master.value)-45
	emit_signal("update_Settings",
	music_volume,
	sound_volume,
	$Sliders/CPU_Level/sld_CPU_Level.value)