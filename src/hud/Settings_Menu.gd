extends Control

signal update_Settings(vol_master,vol_music,vol_sound,CPU_level)
export var MAX_SOUND = 0
export var MAX_MUSIC = -15

func _ready():
	$Header/btn_Menu.connect("pressed", self, "return_mm")
	$Sliders/Vol_Master/sld_Master.connect("value_changed",self,"set_max")

func return_mm():
	emit_signal("update_Settings",
	$Sliders/Vol_Master/sld_Master.value,
	$Sliders/Vol_Music/sld_Music.value,
	$Sliders/Vol_Sound/sld_Sound.value,
	$Sliders/CPU_Level/sld_CPU_Level.value)

func set_max(new_scale):
	# Get old max to help keep ratio in later equation ((NewMax-NewMin)/(OldMax-OldMin))*(value-OldMax)+NewMax
	var old_sound_max = $Sliders/Vol_Sound/sld_Sound.max_value
	var old_music_max = $Sliders/Vol_Music/sld_Music.max_value
	var min_sound = $Sliders/Vol_Sound/sld_Sound.min_value
	var min_music = $Sliders/Vol_Music/sld_Music.min_value
	var sound_value = $Sliders/Vol_Sound/sld_Sound.value
	var music_value = $Sliders/Vol_Music/sld_Music.value

	# Change Maxmimum Value of sliders to be maximum of Master Volume
	$Sliders/Vol_Sound/sld_Sound.max_value = min_sound+(MAX_SOUND-min_sound)*new_scale
	$Sliders/Vol_Music/sld_Music.max_value = min_music+(MAX_MUSIC-min_music)*new_scale

	# Updated Value of Slider using new max and old max to keep ratio
	$Sliders/Vol_Sound/sld_Sound.value = ((($Sliders/Vol_Sound/sld_Sound.max_value-$Sliders/Vol_Sound/sld_Sound.min_value)
	/(old_sound_max-$Sliders/Vol_Sound/sld_Sound.min_value))*(sound_value-old_sound_max))
	+$Sliders/Vol_Sound/sld_Sound.max_value

	$Sliders/Vol_Music/sld_Music.value = ((($Sliders/Vol_Music/sld_Music.max_value-$Sliders/Vol_Music/sld_Music.min_value)
	/(old_music_max-$Sliders/Vol_Music/sld_Music.min_value))*(music_value-old_music_max))
	+$Sliders/Vol_Music/sld_Music.max_value

	#Debuging
	print(str($Sliders/Vol_Sound/sld_Sound.value) + " " + 
	str($Sliders/Vol_Sound/sld_Sound.max_value) + " " + str($Sliders/Vol_Sound/sld_Sound.min_value) + " / " +
	str($Sliders/Vol_Music/sld_Music.max_value) + " " +
	str($Sliders/Vol_Music/sld_Music.value) + " " + str($Sliders/Vol_Music/sld_Music.min_value))