# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends CanvasLayer

signal start_game
signal goto_settings

func _ready():
	$StartBtn.connect("pressed", self, "start_button_pressed")
	$SettingBtn.connect("pressed", self, "open_settings")

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$SettingBtn.show()
	$StartBtn.show()
	
func open_settings():
	$StartBtn.hide()
	$MessageLabel.hide()
	$SettingBtn.hide()
	emit_signal("goto_settings")
	
func start_button_pressed():
	$StartBtn.hide()
	$MessageLabel.hide()
	$SettingBtn.hide()
	emit_signal("start_game")
