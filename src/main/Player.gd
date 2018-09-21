# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

var id = "" setget ,get_id
var sound = null

func _init(player_id, player_sound):
	_set_id(player_id)
	_set_sound(player_sound)
	
func _set_id(player_id):
	id = str(player_id)
	
func get_id():
	return id

func _set_sound(player_sound):
	assert player_sound is AudioStreamPlayer
	sound = player_sound

func play_sound():
	sound.play()