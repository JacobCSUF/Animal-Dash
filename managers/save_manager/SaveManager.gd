extends Node

var save_path = "user://save_game.res"
# Called when the node enters the scene tree for the first time.

var saved_data = {}

func _ready() -> void:
	load_game()

	
func save_game():
	var file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(saved_data)
	file.store_string(json_string)
	file.close()
	
	
	
func load_game():
	if not FileAccess.file_exists("res://savegame.save"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var file = FileAccess.open("res://savegame.save", FileAccess.READ)
	var json = file.get_as_text()
	if not json.is_empty():
		saved_data = JSON.parse_string(json)
		

			
	
	
func save_level_data(name1: String,coins,lanterns,complete,new_coins):
	if !saved_data.has("total_coins"):
		saved_data["total_coins"] = new_coins
	else:
		saved_data["total_coins"] += new_coins
		
	saved_data[name1] = {}
	saved_data[name1]["coins"] = coins
	saved_data[name1]["lanterns"] = lanterns
	saved_data[name1]["complete"] = complete
	save_game()

func get_level_coins(name1: String):
	if saved_data.has(name1):
		var cs = saved_data[name1]["coins"]
		return cs.size()
	else:
		return 0
	
func is_level_complete(name1: String):
	if saved_data.has(name1):
		if saved_data[name1].has("complete"):
			return saved_data[name1]["complete"]
	else:
		return false
		

	
func load_level_data(name1: String):
	if saved_data.has(name1):
		saved_data[name1]["coins"] = saved_data[name1]["coins"].map(func(element): return int(element))
		saved_data[name1]["lanterns"] = saved_data[name1]["lanterns"].map(func(element): return int(element))
		return saved_data[name1]
	else:
		return null
	
	
	
func load_lantern_data(name1: String):
	if !saved_data.has(name1):
		return []
	
	if !saved_data[name1].has("lanterns"):
		return []
	
	return saved_data[name1]["lanterns"]

func get_total_coins():
	if saved_data.has("total_coins"):
		return saved_data["total_coins"]
	else:
		return 0


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
	
		get_tree().quit()
