###############################################################################
# Copyright (c) 2023 @themangomago
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
###############################################################################

extends Node

## User config. Holds the actual config.
var user_config := {
	"config_version": 1.0,
	"volume_sound": 1.0,
	"volume_music": 1.0,
	"resolution": Vector2(1152, 648),
	"fullscreen": false
}


func _ready() -> void:
	# Load user config, create if not available
	_load_config()


## Load the user config from hdd and store it in var user_config; create if not exists
func _load_config() -> void:
	# Check if file exists, else store the default config
	if not FileAccess.file_exists("user://config.cfg"):
		_save_config()
		return
	
	# Store config in readable formated file
	var file := FileAccess.open("user://config.cfg", FileAccess.READ)
	var read_data: Dictionary = JSON.new().parse_string(file.get_as_text())
	
	# Check if the version entry exists. This could be used for migration of newer
	#	configs into existing ones (e.g. update case)
	if not read_data.has("config_version"):
		# Assume the file is corrupt
		_save_config()
		return
	
	# Store read data
	user_config = read_data.duplicate()


## Save the user config to hdd
func _save_config() -> void:
	# Store the config in a more readable formated file
	var file := FileAccess.open("user://config.cfg", FileAccess.WRITE)
	file.store_string(JSON.stringify(user_config, "\t"))
