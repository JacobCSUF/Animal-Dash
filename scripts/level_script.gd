extends Node2D
class_name Level

@export var lr: LevelResource


var coins: Dictionary[int,Coin] ={}
var lanterns: Dictionary[int,LanternChain]
signal level_end

var new_coin_counter = 0
var taken_coin_counter = 0
var old_taken = 0

func _ready() -> void:
	
	GameState.start_level()
	for coin: Coin in get_tree().get_nodes_in_group("coin"):
		if coin.coin_index == 0:
			continue
		coin.new_take.connect(_on_new_take)
		coins[coin.coin_index] = coin
		
	
	for lan: LanternChain in get_tree().get_nodes_in_group("lantern"):
		lan.set_lantern_color(lr.flame_color,lr.outline_flame_color)
		if lan.lantern_index == 0:
			continue
		lanterns[lan.lantern_index] = lan
	

	SongManager.set_song(lr.level_number)
	load_level_data()
	

func _on_new_take(taken: bool):
	if taken:
		taken_coin_counter += 1
	else:
		
		new_coin_counter += 1
	

func load_level_data():
	
	var data = SaveManager.load_level_data(lr.level_name)
	if !data:
		return
	var cs = data["coins"]
	var ls = data["lanterns"]
	
	for c in cs:
		coins[c].set_taken()
		old_taken += 1
			
	for l in ls:
		lanterns[l].set_lantern_on()
		

func save_level_data():
	var coins1 = []
	var lans1 = []
	for c in coins:
		if coins[c] is Coin and coins[c].is_taken:
			coins1.append(c)

	for l in lanterns:
		if lanterns[l] is LanternChain and lanterns[l].is_on:
			lans1.append(l)
	print(lans1)
	SaveManager.save_level_data(lr.level_name,coins1,lans1,true,new_coin_counter)
		
		

func _on_level_end_area_entered(_area: Area2D) -> void:
	var counter = 0
	var total_coins = 0
	for c in coins:
		total_coins += 1
		if coins[c] is Coin and coins[c].is_taken:
			counter += 1
	var lans1 = []
	for l in lanterns:
		if lanterns[l] is LanternChain and lanterns[l].is_on:
			
			lans1.append(l)
			
	save_level_data()
	level_end.emit(total_coins,old_taken,lans1,lr.outline_flame_color,taken_coin_counter,new_coin_counter)
