extends Node
class_name MenuHandler
@onready var main: Node = $".."
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var pause_card: Control = $CanvasLayer/pause_card
@onready var pause_button: ButtonExtended = $CanvasLayer/pause_button
@onready var menu_theme: AudioStreamPlayer = $"../MenuTheme"
@onready var win_card: WinCard = $CanvasLayer/win_card


enum Menus{MAIN,LEVEL,SETTINGS,EXIT,BACK,LEVELBACK,PAUSE, RESUME, REFRESH}


const MAIN_MENU = preload("uid://b35wi34svu1ui")
const LEVEL_MENU = preload("uid://b26w05uqbxffg")





var curr_menu: Control
var curr_level_packed: PackedScene
var curr_level: Level
var level_counter = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.died.connect(_on_died)
	menu_theme.play()
	change_menu(Menus.MAIN)
	
	
	pause_button.b_pressed.connect(change_menu)
	pause_card.button_pressed.connect(change_menu)
	win_card.button_pressed.connect(change_menu)
	
func change_menu(type1):
	print_orphan_nodes()
	if type1 == Menus.PAUSE or type1 == Menus.RESUME:
		pass
	else:
		if curr_menu:
			curr_menu.queue_free()
		if curr_level != null:
			print('IM NULL BITCHA')
			curr_level.queue_free()
			await curr_level.tree_exited
			curr_level = null
			
			
	win_card.visible = false
	match type1:
		
		Menus.MAIN:
			menu_theme.play()
			SongManager.stop_s()
			pause_button.visible = false
			curr_menu = MAIN_MENU.instantiate()
			curr_menu.button_pressed.connect(_on_pressed)
			add_child(curr_menu)
		
		Menus.LEVEL:
			curr_menu = LEVEL_MENU.instantiate()
			curr_menu.set_counter(level_counter)
			curr_menu.button_pressed.connect(_on_pressed)
			curr_menu.level_select.connect(_on_level)
			add_child(curr_menu)
		
		Menus.SETTINGS:
			#instance settings
			pass
	
		####going back from level menu
		Menus.BACK:
			curr_menu = MAIN_MENU.instantiate()
			curr_menu.button_pressed.connect(_on_pressed)
			add_child(curr_menu)

		####going back from pause
		Menus.LEVELBACK:
			get_tree().paused = false
			pause_button.visible = false
			pause_card.visible = false
			menu_theme.play()
			SongManager.stop_s()
			curr_menu = LEVEL_MENU.instantiate()
			curr_menu.set_counter(level_counter)
			curr_menu.button_pressed.connect(_on_pressed)
			curr_menu.level_select.connect(_on_level)
			add_child(curr_menu)
	
		
		Menus.PAUSE:
			pause_button.visible = false
			pause_card.visible = true
		
			get_tree().paused = true
			
	
		Menus.RESUME:
			pause_button.visible = true
			pause_card.visible = false
			get_tree().paused = false
	
		
		Menus.REFRESH:
			pause_card.visible = false
			get_tree().paused = false
			_on_level(curr_level_packed)
			
	
func _on_pressed(type1: Menus):
	change_menu(type1)



func _on_level(level: PackedScene):
 	
	if curr_menu:
		level_counter = curr_menu.get_counter()
		curr_menu.queue_free()
	if curr_level != null:
		curr_level.queue_free()
		await curr_level.tree_exited
		curr_level = null
	
	menu_theme.stop()
	curr_level = level.instantiate()
	curr_level_packed = level
	curr_level.level_end.connect(_on_level_end)
	
	pause_button.visible = true

	call_deferred("add_child",curr_level)
	

	
	
func _on_level_end(t_coin,n_coin,l_array,f,taken_c,new_c):
	
	win_card.visible = true
	win_card.set_coins(t_coin,n_coin,l_array,f,taken_c,new_c)
	

func _on_died():
	if curr_level:
		
		_on_level(curr_level_packed)
