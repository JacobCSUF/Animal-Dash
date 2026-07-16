extends TileMapLayer
class_name BaseTiles
@export var watch:= true


func _process(_delta: float) -> void:
	if !watch or !GameState.player:
		return
	
	var pl = self.to_local(GameState.player_location)
	
	if !pl:
		return
		
	var pl1 = pl + Vector2(0,10)
	var pl2 = pl + Vector2(0,-10)
	var pl3 = pl + Vector2(10,0)
	var pl4 = pl + Vector2(-10,0)
	
	
	var cell1 = local_to_map(pl1)
	var cell2 = local_to_map(pl2)
	var cell3 = local_to_map(pl3)
	var cell4 = local_to_map(pl4)
	
	var td1 = get_cell_tile_data(cell1)
	var td2 = get_cell_tile_data(cell2)
	var td3 = get_cell_tile_data(cell3)
	var td4 = get_cell_tile_data(cell4)
	
	var tile_array = [td1,td2,td3,td4]
	
	for i in tile_array:
		if i:
			if i.get_custom_data("type"):
				print('SHOULD DIE')
				watch = false
				GameState.die()
