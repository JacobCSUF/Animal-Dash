extends Control

signal button_pressed(menu: MenuHandler.Menus)
@onready var main_block: Node2D = $main_block
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_levels_menu_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	button_pressed.emit(MenuHandler.Menus.LEVEL)
	

func _on_settings_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	#button_pressed.emit(MenuHandler.Menus.SETTINGS)
	animation_player.play("settings_shift")
	


func _on_exit_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	get_tree().quit()


func _on_settings_menu_back() -> void:
	animation_player.play("settings_back")


func _on_shop_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	animation_player.play("shop_shift")

func _on_shop_menu_back() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	animation_player.play("shop_back")
