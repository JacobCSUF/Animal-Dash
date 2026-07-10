extends Node2D

@export var angle: int
@export var length: int = 500
@export var laser_beam_76426: AudioStreamPlayer2D
@export var auto_shoot = true

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var laser_line: Line2D = $laser_line
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

@onready var collision_shape_2d: CollisionShape2D = $kill_area/CollisionShape2D

var unit_vector
var shoot = true
var shoot_time = 2
var shoot_counter = 0

func _ready() -> void:
	unit_vector = Vector2.RIGHT.rotated(deg_to_rad(angle))
	reset_laser()
	if auto_shoot:
		fire(2)

func fire(_time = 2):
	shoot_time = _time
	shoot_counter = 0

	if laser_beam_76426:
		laser_beam_76426.play()
		var tween = create_tween()
		tween.tween_property(laser_beam_76426, "volume_db", -10.0, 0.25)

	shoot = false
	gpu_particles_2d.emitting = true

func _physics_process(delta: float) -> void:
	if not shoot:
		if shoot_counter < shoot_time:
			shoot_counter += delta
			
			# Stop laser at max length
			if ray_cast_2d.target_position.length() > length:
				return
			
			# Move laser tip
			ray_cast_2d.target_position -= unit_vector * 5
			laser_line.points[1] = ray_cast_2d.target_position
			
			# Update GPU particles to match laser
			var laser_len = ray_cast_2d.target_position.length()
			gpu_particles_2d.rotation = deg_to_rad(angle)
			gpu_particles_2d.process_material.emission_box_extents = Vector3(laser_len / 1.75, 10, 0)
			gpu_particles_2d.process_material.emission_shape_offset = Vector3(-laser_len / 1.75, 0, 0)
			collision_shape_2d.rotation = deg_to_rad(angle)
			
			collision_shape_2d.position = ray_cast_2d.target_position/2
			collision_shape_2d.shape.size.x = laser_len
			
		else:
			reset_laser()

func reset_laser():
	if laser_beam_76426:
		laser_beam_76426.stop()
		laser_beam_76426.volume_db = -30
	

	gpu_particles_2d.emitting = false
	gpu_particles_2d.process_material.emission_box_extents = Vector3(0, 10, 0)
	gpu_particles_2d.process_material.emission_shape_offset = Vector3(0, 0, 0)
	
	collision_shape_2d.position = Vector2(0,0)
	collision_shape_2d.shape.size.x = 0

	
	shoot_counter = 0
	shoot = true
	ray_cast_2d.target_position = Vector2.ZERO
	laser_line.points[1] = ray_cast_2d.target_position
