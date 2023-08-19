extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("menu_show", Callable(self, "_show_menu"))
	Events.connect("menu_hide", Callable(self, "_hide_menu"))
	_show_menu()


func _show_menu():
	$World/HUD/Menu.show()
	$World/HUD/Menu.update_menu()

func _hide_menu():
	$World/HUD/Menu.hide()
