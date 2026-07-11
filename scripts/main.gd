extends Node

func _ready() -> void:
	
	tree_exiting.connect(_on_te)
	GameState.main_menu = true
	pass

func _on_te():
	print_orphan_nodes()
