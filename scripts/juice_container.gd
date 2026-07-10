extends Node2D
@onready var energy_tank: Sprite2D = $EnergyTank
@onready var juice: Sprite2D = $Juice
@onready var juice_2: Sprite2D = $Juice2
@onready var water_pump: AudioStreamPlayer2D = $Area2D/WaterPump
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var point_light_2d: PointLight2D = $Path2D/PathFollow2D/PointLight2D

var pump = false

func toggle_light_mask_off() -> void:
	for node in [energy_tank, juice, juice_2]:
		node.light_mask = node.light_mask & ~1




func _process(delta: float) -> void:
	if pump:
		path_follow_2d.progress += delta *200


func _on_area_2d_area_entered(area: Area2D) -> void:
	water_pump.play()
	pump = true
	point_light_2d.visible = true
