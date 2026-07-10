extends Control
class_name  WinCard

@onready var coin_label: Label = $Coin_label

signal button_pressed(menu: MenuHandler.Menus)

func _on_resume_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_redo_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_level_select_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)

func set_coins(total:int,num:int):
	coin_label.text = "Coins: "+ str(num)+"/" + str(total)
