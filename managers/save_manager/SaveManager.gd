extends Node

var save_path = "user://save_game.res"
# Called when the node enters the scene tree for the first time.

var saved_data = {}

func _ready() -> void:
	load_game()

	
func save_game():
	var file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	var json = file.get_as_text()
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
		

			
	
	
func save_level_data(name: String,coins,lanterns,complete):
	saved_data[name] = {}
	saved_data[name]["coins"] = coins
	saved_data[name]["lanterns"] = lanterns
	saved_data[name]["complete"] = complete
	

func get_level_coins(name: String):
	if saved_data.has(name):
		var cs = saved_data[name]["coins"]
		return cs.size()
	else:
		return 0
	
func is_level_complete(name: String):
	if saved_data.has(name):
		if saved_data[name].has("complete"):
			return saved_data[name]["complete"]
	else:
		return false
		

	
func load_level_data(name: String):
	if saved_data.has(name):
		saved_data[name]["coins"] = saved_data[name]["coins"].map(func(element): return int(element))
		saved_data[name]["lanterns"] = saved_data[name]["lanterns"].map(func(element): return int(element))
		return saved_data[name]
	else:
		return null
	
	
	
func load_lantern_data(name: String):
	if !saved_data.has(name):
		return []
	
	if !saved_data[name].has("lanterns"):
		return []
	
	return saved_data[name]["lanterns"]
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
	
		get_tree().quit()
