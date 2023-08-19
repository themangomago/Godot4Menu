extends Node

## Emitted when the player wants to start a new game
signal gm_new_game()
## Emitted when the player wants to load a game
signal gm_load_game()
## Emitted when the player wants to save a game
signal gm_save_game()

## Play some sound
signal play_sound(sound)

## Switch to main menu
signal menu_switch_main_menu()
