extends Control

signal button_pressed(menu: MenuHandler.Menus)

func _on_resume_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_redo_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_level_select_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)
