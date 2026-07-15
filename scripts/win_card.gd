extends Control
class_name  WinCard

@onready var new_coins: Label = $new_coins
@onready var coin_total: Label = $coin_total
@onready var coin_increase: Label = $coin_increase


@onready var lantern_group_ui: LanternGroupUI = $lantern_group_ui

signal button_pressed(menu: MenuHandler.Menus)

func _on_resume_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_redo_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_level_select_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)

func start_end():
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 1.0),1)
	
func set_coins(total:int,num:int,l:Array,f:Color,tc: int,oc: int):
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	await get_tree().create_timer(1.0).timeout
	
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 1.0),1)
	
	new_coins.text = str(nc)
	#coin_label.text =str(num)+"/" + str(total)
	lantern_group_ui.set_lanterns(l,f,f)
