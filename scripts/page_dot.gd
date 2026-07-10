extends Control

@onready var ui_button: Sprite2D = $UiButton
@onready var ui_button_filled: Sprite2D = $UiButtonFilled


func toggle_on():
	ui_button_filled.visible = true
	
func toggle_off():
	ui_button_filled.visible = false
	
