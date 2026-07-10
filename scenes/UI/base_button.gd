extends Button
class_name ButtonExtended

@export var to_menu: MenuHandler.Menus

signal b_pressed(m: MenuHandler.Menus)

func _on_pressed():
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	b_pressed.emit(to_menu)
	
