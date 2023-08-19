extends Control

@onready var Node_Music_Bus = AudioServer.get_bus_index("Music")
@onready var Node_Sound_Bus = AudioServer.get_bus_index("Sound")

var game_is_active: bool = false


func _ready():
	# Hide stuff
	update_menu()
	# Show main menu
	_on_button_back_button_up()
	
	# Init Sound, Music and Resolution from here.
	# In more complex projects this logic wouldnt be here
	_on_volume_sound_update_setting(Global.user_config.volume_sound)
	_on_volume_music_update_setting(Global.user_config.volume_music)
	_on_resolution_update_setting(Global.user_config.resolution)


func update_menu() -> void:
	if game_is_active:
		$Views/Main/v/ButtonResume.show()
		$Views/Main/v/ButtonSaveGame.show()
	else:
		$Views/Main/v/ButtonResume.hide()
		$Views/Main/v/ButtonSaveGame.hide()


func _on_button_resume_button_up():
	Events.emit_signal("menu_hide")
	get_tree().paused = false


func _on_button_new_game_button_up():
	game_is_active = true
	Events.emit_signal("gm_new_game")
	Events.emit_signal("menu_hide")
	get_tree().paused = false


func _on_button_save_game_button_up():
	Events.emit_signal("gm_save_game")
	Events.emit_signal("menu_hide")
	get_tree().paused = false


func _on_button_load_game_button_up():
	game_is_active = true
	Events.emit_signal("gm_load_game")
	Events.emit_signal("menu_hide")
	get_tree().paused = false


func _on_button_quit_button_up():
	get_tree().quit()


func _on_button_settings_button_up():
	# Set the actual values
	$Views/Settings/v/Resolution.update_value(Global.user_config.resolution)
	$Views/Settings/v/VolumeSound.update_value(Global.user_config.volume_sound)
	$Views/Settings/v/VolumeMusic.update_value(Global.user_config.volume_music)
	
	# Show settings
	$Views/Main.hide()
	$Views/Settings.show()


func _on_chicken_button_button_up():
	$Interactable/ChickenSprite/AnimationPlayer.play("poke")
	$Interactable/ChickenSprite/AudioStreamPlayer2D.play()


func _on_turtle_button_button_up():
	$Interactable/TurtleSprite/AnimationWalk.play("walk")
	$Interactable/TurtleSprite/AnimationTransition.play("walk")
	$Interactable/TurtleSprite/AudioStreamPlayer2D.play()


func _on_button_back_button_up():
	$Views/Main.show()
	$Views/Settings.hide()


func _on_resolution_update_setting(value):
	# Index to float
	var resolution: Vector2 = Global.RESOLUTION_OPTIONS[value]
	print("Sound volume set to: " + str(resolution))
	# Store in user config
	Global.user_config.resolution = value
	# Set resolution
	get_viewport().size = resolution
	# Save config
	Global._save_config()


func _on_volume_sound_update_setting(value):
	# Index to float
	var volume: float = Global.VOLUME_OPTIONS[value]
	print("Sound volume set to: " + str(volume))
	# Store in user config
	Global.user_config.volume_sound = value
	# Set bus volume
	AudioServer.set_bus_volume_db(Node_Sound_Bus, linear_to_db(float(volume)/10))
	# Save config
	Global._save_config()


func _on_volume_music_update_setting(value):
	# Index to float
	var volume: float = Global.VOLUME_OPTIONS[value]
	print("Music volume set to: " + str(volume))
	# Store in user config
	Global.user_config.volume_music = value
	# Set bus volume
	AudioServer.set_bus_volume_db(Node_Music_Bus, linear_to_db(float(volume)/10))
	# Save config
	Global._save_config()


