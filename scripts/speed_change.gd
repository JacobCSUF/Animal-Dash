extends BaseObject

@export_range(-1.0,1.0) var speed_change = 0.0



@onready var particles: GPUParticles2D = $particles

func _ready() -> void:
	super()



func _on_direct_area_area_entered(area: Area2D) -> void:
	particles.global_position = area.global_position
	particles.emitting = true
	GameState.player.modify_speed(speed_change)
