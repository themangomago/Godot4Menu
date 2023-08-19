extends Control

@export var button_name: String = "Text"
@export var type: Types.DataTypes = Types.DataTypes.Float

signal update_setting(value)

## Indication if its hovered
var is_focused: bool = false
## Holds the options
var options = []
## Current index selected
var index = 0

func _ready():
	# Set the name
	$h/Label.set_text(button_name)
	
	# Set options
	if type == Types.DataTypes.Float:
		options = Global.VOLUME_OPTIONS
	else:
		options = Global.RESOLUTION_OPTIONS
		
	# Dummy write option text
	$h/Option.set_text(str(options[options.size() - 1]))


## Update option text
func update_value(value: int):
	index = value
	$h/Option.set_text(str(options[index]))

## Switch handling
func _switch(direction: int):
	index += direction
	
	# Boundaries
	if index < 0: 
		index = options.size() - 1
	elif index >= options.size():
		index = 0
	
	# Update text
	$h/Option.set_text(str(options[index]))
	# Commit changes
	emit_signal("update_setting", index)


func _on_focus_entered():
	is_focused = true
	$Bg.show()


func _on_focus_exited():
	is_focused = false
	$Bg.hide()


func _on_mouse_entered():
	_on_focus_entered()


func _on_mouse_exited():
	_on_focus_exited()


func _on_button_last_gui_input(event):
	_on_focus_entered()
	if event is InputEventMouseButton:
		if not event.pressed:
			_switch(-1)


func _on_button_next_gui_input(event):
	_on_focus_entered()
	if event is InputEventMouseButton:
		if not event.pressed:
			_switch(1)
