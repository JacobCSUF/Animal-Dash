extends Control

@export var levels: Array[PackedScene] = []

@onready var lantern_chain: LanternChain = $lantern_chain
@onready var lantern_chain_2: LanternChain = $lantern_chain2
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var level_title: Label = $HBoxContainer/level_title
@onready var panel: Panel = $Panel

@onready var play: ButtonExtended = $play
@onready var back: ButtonExtended = $back

@onready var coin_label: Label = $Coin2/coin_label


signal level_select(level: PackedScene)
signal button_pressed(menu: MenuHandler.Menus)

var level_index = 0
var dis

var level_dict = {
	0:{
		"level": preload("uid://dbqh6h7t28qom"),
		"display": preload("uid://disgsoafkm0u")
		},
	1:{
		"level": preload("uid://ch6lwsy7qhuyy"),
		"display": preload("uid://bua33pm7s8osp")
		},
	2:{
		"level": preload("uid://wo3dmqtdsl6q"),
		"display": preload("uid://ib4gqkuisr50")
		}
		,
	3:{
		"level":preload("uid://56iwvm0o1mvm") ,
		"display": preload("uid://dk5uyd3ncdtqd")
		}
		
	}
	

func _ready():
	set_level()
	
func set_counter(ind:= 0):
	level_index = ind

func get_counter():
	return level_index

func set_level():
	if dis:
		dis.queue_free()

	
	var leve = level_dict[level_index]
	var lev: Level = leve["level"].instantiate()
	var lr = lev.lr
	var c = lr.ui_color
	var l = lr.lantern_color
	

	
	lantern_chain.set_lantern_color(l)

	lantern_chain_2.set_lantern_color(l)
	level_title.text = lr.level_name

	var num_coins = SaveManager.get_level_coins(lr.level_name)
	
	set_coins(lr,num_coins)

		# Panels

	var stylebox1 := panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	stylebox1.border_color = c
	panel.add_theme_stylebox_override("panel", stylebox1)

	# Button border
	for state in ["normal", "hover", "pressed", "focus", "disabled"]:
		var stylebox := play.get_theme_stylebox(state).duplicate() as StyleBoxFlat
		stylebox.border_color = c
		play.add_theme_stylebox_override(state, stylebox)

	# Title outline color
	level_title.add_theme_color_override("font_outline_color", c)

	dis = leve["display"].instantiate()
	add_child(dis)


func set_coins(lr: LevelResource,num: int):
	var cs = lr.total_coins
	coin_label.text = str(num)+"/" + str(cs)
	


func _on_up_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	level_index = (level_index - 1) % level_dict.size()
	if level_index < 0:
		level_index = level_dict.size() -1
	set_level()


func _on_down_pressed() -> void:
	AudioManager.play_sound(AudioManager.Sound.UIBUTTON)
	level_index = (level_index + 1) % level_dict.size()
	set_level()




func _on_back_b_pressed(m: MenuHandler.Menus) -> void:
	button_pressed.emit(MenuHandler.Menus.BACK)


func _on_play_b_pressed(m: MenuHandler.Menus) -> void:
	dis.queue_free()
	level_select.emit(level_dict[level_index]["level"])
