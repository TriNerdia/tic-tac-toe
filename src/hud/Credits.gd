# Copyright (c) 2018 TriNerdia
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

extends Node

# Custom Signals
signal return_mm

# Variables

# Godot Engine Functions
func _ready():
	$BackBtn.connect("pressed", self, "return_mainmenu")

# Local Functions
func return_mainmenu():
	emit_signal("return_mm")