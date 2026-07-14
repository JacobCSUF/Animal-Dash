extends Node2D
class_name Level

@export var lr: LevelResource


var coins: Array[Coin] = []
var lanterns: Array[LanternChain]
signal level_end

func _ready() -> void:
	GameState.start_level()
	for coin: Coin in get_tree().get_nodes_in_group("coin"):
		if coin.coin_index == 0:
			continue
		coins.append(coin)
	
	for lan: LanternChain in get_tree().get_nodes_in_group("lantern"):
		lan.set_lantern_color(lr.flame_color,lr.outline_flame_color)
		if lan.lantern_index == 0:
			continue

		lanterns.append(lan)
	
	SongManager.set_song(lr.level_number)
	load_level_data()
	


func load_level_data():
	return
	var data = SaveManager.load_level_data(lr.level_name)
	if !data:
		return
	var cs = data["coins"]
	for c in cs:
		if c <= cs.size():
			coins[c].set_taken()

func save_level_data():
	var coins1 = []
	for c in coins:
		if c is Coin and c.is_taken:
			coins1.append(c.coin_index - 1)

	SaveManager.save_level_data(lr.level_name,coins1,true)
		
		



func _on_level_end_area_entered(area: Area2D) -> void:
	var counter = 0
	var t_counter = 0
	for c in coins:
		t_counter += 1
		if c is Coin and c.is_taken:
			counter += 1
		
	save_level_data()
	level_end.emit(t_counter,counter)
