extends Node

var save_path = "user://save_game.res"
# Called when the node enters the scene tree for the first time.

var saved_data = {}

signal currency_updated(coins:int,lans:int)

var ini_saved_data = {
	"total_coins": 0,
	"total_lanterns": 0,
	"0": {
		"completed": false,
		"locked": false,
		"coins": [],
		"lanterns": []
	},
	"1":{
		"completed": false,
		"locked": false,
		"coins": [],
		"lanterns": []
		},
		
	
	"2":{
		"completed": false,
		"locked": false,
		"coins": [],
		"lanterns": []
		},
	
	"3":{
		"completed": false,
		"locked": true,
		"cost": 5,
		"coins": [],
		"lanterns": []
		},
		
	
	"4":{
		"completed": false,
		"locked": false,
		"coins": [],
		"lanterns": []
		},
	
	"skins":{
		"0":
			{
			"bought":true,
			"cost": 0
			},
		"1":{
			"bought":false,
			"cost": 20
		},
		"2":{
			"bought":false,
			"cost": 20
		},
		"3":{
			"bought":false,
			"cost": 20
		},
		"4":{
			"bought":false,
			"cost": 20
		},
		"5":{
			"bought":false,
			"cost": 20
		},
		
	}
	}

func _ready() -> void:
	load_game()

	
func save_game():
	var file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(saved_data)
	file.store_string(json_string)
	file.close()
	
	
	
func load_game():
	if not FileAccess.file_exists("res://savegame.save"):
		saved_data = ini_saved_data
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var file = FileAccess.open("res://savegame.save", FileAccess.READ)
	var json = file.get_as_text()
	if not json.is_empty():
		saved_data = JSON.parse_string(json)
	

			
	
	
func save_level_data(n1: int,coins,lanterns,complete,new_coins,new_lans):
	var name1 = str(n1)
	
	if !saved_data.has("total_coins"):
		saved_data["total_coins"] = new_coins
	else:
		saved_data["total_coins"] += new_coins
	
	saved_data["total_lanterns"] += new_lans
		
	currency_updated.emit()
		
	saved_data[name1]["coins"] = coins
	saved_data[name1]["lanterns"] = lanterns
	saved_data[name1]["complete"] = complete
	save_game()

func get_level_coins(n1: int):
	var name1 = str(n1)
	if saved_data.has(name1):
		var cs = saved_data[name1]["coins"]
		return cs.size()
	else:
		return 0
	
func is_level_complete(n1: int):
	var name1 = str(n1)
	if saved_data.has(name1):
		if saved_data[name1].has("complete"):
			return saved_data[name1]["complete"]
	else:
		return false
		

	
func load_level_data(n1: int):
	var name1 = str(n1)
	if saved_data.has(name1):
		saved_data[name1]["coins"] = saved_data[name1]["coins"].map(func(element): return int(element))
		saved_data[name1]["lanterns"] = saved_data[name1]["lanterns"].map(func(element): return int(element))
		return saved_data[name1]
	else:
		return null
	
	
	
func load_lantern_data(n1: int):
	var name1 = str(n1)
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

func get_total_lanterns():
	if saved_data.has("total_lanterns"):
		return saved_data["total_lanterns"]
	else:
		return 0

func is_level_locked(n1: int):
	var name1 = str(n1)
	if saved_data.has(name1):
		return saved_data[name1]["locked"]
	
func get_locked_lantern_count(n1: int):
	if is_level_locked(n1):
		var name1 = str(n1)
		return saved_data[name1]["cost"]

func unlock_level(n1: int):
	var name1 = str(n1)
	saved_data[name1]["locked"] = false


func has_bought_skin(n1: int):
	var name1 = str(n1)
	return saved_data["skins"][name1]["bought"]
	
func get_skin_cost(n1: int):
	var name1 = str(n1)
	return saved_data["skins"][name1]["cost"]

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
	
		get_tree().quit()
