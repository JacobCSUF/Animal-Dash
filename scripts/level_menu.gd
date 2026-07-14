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

const PAGE_DOT = preload("uid://cihhs64uxc1ot")
@onready var pagnation: HBoxContainer = $pagnation

@onready var cleared_panel: Panel = $cleared_panel
@onready var clear_no: Label = $cleared_panel/clear_no
@onready var clear_yes: Label = $cleared_panel/clear_yes
@onready var difficulty: Panel = $difficulty
@onready var difficulty_ui: Node2D = $difficulty/difficulty_ui

@onready var lantern_ui: LanternGroupUI = $lantern_ui


signal level_select(level: PackedScene)
signal button_pressed(menu: MenuHandler.Menus)

var level_index = 0
var dis
var page_dots = []

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
		
	,
	4:{
		"level": preload("uid://cyyl1oxo6aylr"),
		"display": preload("uid://c18vgg0cwph63")
		}
		
	}
	

func _ready():
	
	for i in range(level_dict.size()):
		
		var d = PAGE_DOT.instantiate()

		pagnation.add_child(d)
		page_dots.append(d)
		if i == 0:
			d.toggle_on()
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
	var f = lr.flame_color
	var o  = lr.outline_flame_color
	
	for i in range(page_dots.size()):
		if i == level_index:
			page_dots[i].toggle_on()
		else:
			page_dots[i].toggle_off()
	
	lantern_chain.set_lantern_color(f,o)
	difficulty_ui.set_difficulty(lr.difficulty)
	lantern_chain_2.set_lantern_color(f,o)
	level_title.text = lr.level_name

	var num_coins = SaveManager.get_level_coins(lr.level_name)
	var lev_data = SaveManager.load_level_data(lr.level_name)
	var lan_data = SaveManager.load_lantern_data(lr.level_name)
	var complete = SaveManager.is_level_complete(lr.level_name)
	
	lantern_ui.set_lanterns(lan_data,o,o)
	
	if complete:
		clear_no.visible = false
		clear_yes.visible = true
	else:
		clear_no.visible = true
		clear_yes.visible = false
	
	set_coins(lr,num_coins)

		# Panels

	var stylebox1 := panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	stylebox1.border_color = c
	panel.add_theme_stylebox_override("panel", stylebox1)
	
	var stylebox2 := cleared_panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	stylebox2.border_color = c
	cleared_panel.add_theme_stylebox_override("panel", stylebox2)
	difficulty.add_theme_stylebox_override("panel", stylebox2)
	
	# Button border
	for state in ["normal", "hover", "pressed", "focus", "disabled"]:
		var stylebox := play.get_theme_stylebox(state).duplicate() as StyleBoxFlat
		stylebox.border_color = c
		play.add_theme_stylebox_override(state, stylebox)

	# Title outline color
	level_title.add_theme_color_override("font_outline_color", c)
	


	dis = leve["display"].instantiate()
	print(self.global_position,' SELF POS')
	print(dis.global_position)
	add_child(dis)
	lev.queue_free()


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
