extends Control

var game_is_active: bool = false


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
	pass # Replace with function body.
