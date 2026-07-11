extends Node2D

@onready var float_particles: GPUParticles2D = $float_particles
@onready var dash_particle: GPUParticles2D = $dash_particle
@onready var ball_hit_particle: GPUParticles2D = $ball_hit_particle
@onready var wave: GPUParticles2D = $wave



func reset():
	float_particles.emitting= false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	float_particles.emitting= false
	

func set_animal():
	if GameState.animal_resource:
		set_dash_texture()
		set_dash_color()
		set_float_color()


func set_dash_texture():
	var a = AtlasTexture.new()
	a.atlas = GameState.animal_resource.sprites
	a.region = Rect2(0.0,32.0,32.0,32.0)
	dash_particle.texture = a
	
	
func set_dash_color():
	var mat := dash_particle.process_material as ParticleProcessMaterial
	mat.color_ramp = GameState.animal_resource.dash_colors

func set_float_color():
	var mat := float_particles.process_material as ParticleProcessMaterial
	mat.color_ramp = GameState.animal_resource.float_colors
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = GameState.player_location

func play_float_trail():
	
	float_particles.emitting= true
	
func stop_float_trail():
	float_particles.emitting= false
	
	
func start_cart_particles():
	wave.emitting = true

	
func stop_cart_particles():
	wave.emitting = false

func play_dash(num: int = 5, time: float = 0.2):
	if num == 0:
		return
	dash_particle.lifetime = time
	dash_particle.amount = num
	dash_particle.restart()
	dash_particle.emitting = true
	
	
func play_ball():
	ball_hit_particle.restart()
	ball_hit_particle.emitting = true
