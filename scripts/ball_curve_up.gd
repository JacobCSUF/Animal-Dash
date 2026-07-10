@tool
extends Path2D
@onready var line_2d: Line2D = $Line2D

@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ps = curve.get_baked_points()
	line_2d.points = ps
	collision_polygon_2d.polygon = ps
