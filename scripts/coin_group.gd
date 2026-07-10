extends Node2D

@export_range(0, 10) var level: int

var my_list: Array[int] = []
var coins: Array[Coin] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for coin in get_children():
		if coin is Coin:
			coins.append(coin)

	var coin_data = GameState.coins[0]
	
	for i in range(coin_data.size()):
		if coins.size() <= i:
			break
		if coin_data[i] == 1:
			coins[i].collected()
		
	
	
