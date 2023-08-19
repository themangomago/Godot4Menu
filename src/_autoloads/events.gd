extends Node

## Emitted when the player wants to start a new game
signal gm_new_game()
## Emitted when the player wants to load a game
signal gm_load_game()
## Emitted when the player wants to save a game
signal gm_save_game()

## Emitted from game scene to switch to main menu
signal menu_show()
## Emitted when menu shall hide
signal menu_hide()
