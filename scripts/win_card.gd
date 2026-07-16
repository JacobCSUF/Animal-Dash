extends Control
class_name  WinCard

@export var cookies =1

@onready var curr_coins: Label = $VBoxContainer/curr_coins
@onready var total_coins: Label = $VBoxContainer/total_coins
@onready var taken_coins: Label = $VBoxContainer/taken_coins
@onready var lantern_group_ui: LanternGroupUI = $lantern_group_ui

var appears = []

signal button_pressed(menu: MenuHandler.Menus)

func _on_resume_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_redo_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)


func _on_level_select_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(m)
@onready var poof: AudioStreamPlayer = $Poof

func set_coins(total:int,num:int,l:Array,f:Color,tc: int,new: int):
	for i in appears:
		i.visible = false
	appears = []
	lantern_group_ui.reset_group()
	
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	await get_tree().create_timer(0.5).timeout
	
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0, 1.0, 1.0, 1.0),1)
	await tween.finished
	

	
	
		
	if (total-num) == 0:
		curr_coins.visible = false
	else:
		appears.append(curr_coins)
	
	
	
	if num == 0:
		taken_coins.visible = false
	else:
		appears.append(taken_coins)
	
	appears.append(total_coins)
	appears.append(lantern_group_ui)
	
	
	
	
	curr_coins.text = "       "+str(new)+"/" + str(total-num)
	
	taken_coins.text ="       "+str(tc) +"/" + str(num)
	total_coins.text ="Total: "+str(num)+"/" + str(total)
	
	for i in appears:
		
		poof.play()
		i.visible = true
		await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(0.3).timeout
	for i in range(new):
		total_coins.text ="Total: "+str(num+i+1)+"/" + str(total)
		await get_tree().create_timer(0.1).timeout
		AudioManager.play_sound(AudioManager.Sound.COIN)
	await get_tree().create_timer(0.3).timeout
	total_coins.text ="Total: "+str(num+new)+"/" + str(total)
	
	lantern_group_ui.turn_on_group(l,f,f)
