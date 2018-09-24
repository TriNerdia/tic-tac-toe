extends "res://src/main/Player.gd"

# How strong is CPU - Easy, 0 - Normal, 1
var level

func _init(cpu_id, cpu_sound, cpu_lv).(cpu_id,cpu_sound):
	_set_cpu_lv(cpu_lv)
	
func isType(type):
	return "CPU" == type
	
func _set_cpu_lv(cpu_lv):
	level = cpu_lv
	
func get_cpu_lv():
	return level
	
func CPU_Turn(playable_spots):
	if playable_spots == []:
		return -1
	else:
		return playable_spots[rand_range(0,len(playable_spots))]
		

