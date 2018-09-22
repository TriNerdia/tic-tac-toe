# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends CanvasLayer

signal start_game
signal CPU_On_Off

func _ready():
	$StartBtn.connect("pressed", self, "start_button_pressed")

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$StartBtn.show()
	
func start_button_pressed():
	$StartBtn.hide()
	$MessageLabel.hide()
	$CPU_Btn.hide()
	emit_signal("start_game")


func _on_CPU_Btn_toggled(button_pressed):
	emit_signal("CPU_On_Off")
	if button_pressed:
		$CPU_Btn.text = "CPU ON"
	else:
		$CPU_Btn.text = "CPU OFF"
