extends Node2D

var velocity: Vector2 = Vector2(128, 128)
var target_color: Color
var rng : RandomNumberGenerator


func _ready():
	Events.connect("gm_new_game", Callable(self, "_new_game"))
	Events.connect("gm_load_game", Callable(self, "_load_game"))
	Events.connect("gm_save_game", Callable(self, "_save_game"))
	
	rng = RandomNumberGenerator.new()
	rng.randomize()
	_random_color()

func _physics_process(delta):
	if $Body.get_last_slide_collision():
		velocity = velocity.bounce($Body.get_last_slide_collision().get_normal())
	$Body.velocity = velocity
	$Body.move_and_slide()


## Starts a new game
func _new_game() -> void:
	# Reset values
	velocity = Vector2(128, 128)
	$Body.position = Vector2(576, 320)
	_random_color()
	_tween_color()
	print("Game started..")


## Starts a game from a save game
func _load_game() -> void:
	var saveable = Global.load_game()
	if saveable.has("velocity") && saveable.has("position") && saveable.has("color"):
		velocity = str_to_var("Vector2" + saveable.velocity)
		$Body.position = str_to_var("Vector2" + saveable.position)
		target_color = str_to_var("Color" + saveable.color)
		_tween_color()
		print("Game loaded..")
	else:
		printerr("Error loading game")


## Saves the current state
func _save_game() -> void:
	if Global.save_game({
		"velocity": velocity,
		"position": $Body.position,
		"color": target_color
	}) != OK:
		printerr("Error saving game")
	print("Game saved..")

## Get a random color
func _random_color() -> void:
	# Get a random color
	target_color = Color.from_hsv(
		rng.randf_range(0.1, 0.5), # Hue
		rng.randf_range(0.0, 1.0), # Saturation
		rng.randf_range(0.0, 1.0), # Value
		1.0 # Alpha
	)


## Tween to that color
func _tween_color() -> void:
	# Set tween
	var tween = get_tree().create_tween()
	tween.tween_property($Body/Label, "modulate", target_color, 2)
	tween.tween_callback(Callable(self, "_callback_random_and_tween_color")) # Loop from here


## Callback to get new color value
func _callback_random_and_tween_color() -> void:
	_random_color()
	_tween_color()


func _on_ButtonBack_button_up() -> void:
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("menu_show")
	get_tree().paused = true
