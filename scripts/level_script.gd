extends Node2D
class_name Level

@export var lr: LevelResource
@export var total_distance := 20000

var coins: Dictionary[int,Coin] ={}
var lanterns: Dictionary[int,LanternChain]
signal level_end

var new_coin_counter = 0
var taken_coin_counter = 0
var old_taken = 0
var lan_new = 0




var d_dict = {}


func _ready() -> void:
	
	########Calulate total distance of level and send to player
	for flag: PercentFlag in get_tree().get_nodes_in_group("flag"):
		var ind = flag.flag_index
		if !d_dict.has(ind):
			d_dict[ind] = {}
		if flag.is_enter:
			d_dict[ind]["enter"] = flag.global_position.x
		else:
			d_dict[ind]["exit"] = flag.global_position.x
	
		d_dict[ind]["mult"] = flag.flag_divide
	
	for f in d_dict:
		
		total_distance-= (d_dict[f]["exit"] - d_dict[f]["enter"])  
		total_distance += (d_dict[f]["exit"] - d_dict[f]["enter"]) *(d_dict[f]["mult"]) 
		
	GameState.player.distance_helper.get_distance(total_distance)
	
	
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
		lan.lan_new_hit.connect(_on_lan_new_hit)

	SongManager.set_song(lr.level_number)
	load_level_data()
	

func _on_new_take(taken: bool):
	if taken:
		taken_coin_counter += 1
	else:
		
		new_coin_counter += 1
	
func _on_lan_new_hit():
	lan_new += 1
	print("NEW HIT LAN: NOW: ",lan_new)

func load_level_data():
	
	var data = SaveManager.load_level_data(lr.level_number)
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
	SaveManager.save_level_data(lr.level_number,coins1,lans1,true,new_coin_counter,lan_new)
		
		

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
