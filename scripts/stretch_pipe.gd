@tool
extends Node2D

@onready var pipe_mid: Sprite2D = $PipeStretchMiddle
@onready var pipe_bot: Sprite2D = $PipeStretchBottom
@onready var pipe_top: Sprite2D = $PipeStretchTop

@export var size := 32
@onready var col: CollisionShape2D = $kill_area/CollisionShape2D

func _ready() -> void:
	pipe_mid.region_enabled = true
	pipe_mid.region_rect = Rect2(1, 1, 32, size)

	var middle_height = pipe_mid.region_rect.size.y * pipe_mid.scale.y

	# Assumes:
	# - Top pipe's origin is at its BOTTOM
	# - Bottom pipe's origin is at its TOP
	pipe_top.position.y = pipe_mid.position.y - middle_height / 2.0
	pipe_bot.position.y = pipe_mid.position.y + middle_height / 2.0
	
	var total_height = size + 44
	var rec = RectangleShape2D.new()
	rec.size = Vector2(30,total_height)
	col.shape = rec
	
	
	
	
	
	
