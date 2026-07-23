@tool
extends Node2D

@export var bg: BackGroundResource
@export var particles_packed: PackedScene

const SHIMMERSHEET = preload("uid://0pore0i2dbln")

@export_group("BG Nodes")
@export var particles: Array[GPUParticles2D] = []
@export var texture_rect_4: Sprite2D
@export var fog: Sprite2D 

@onready var bg_manager: BG_manager = $managers/bg_manager



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if !bg:
		return

	for p in particles:
		if bg.particle_texture:
			p.texture = bg.particle_texture
		else:
			p.texture = SHIMMERSHEET
		
		p.modulate = bg.p_color
	

	fog.modulate = bg.fog_color
	
	if bg.bg_gradient and texture_rect_4:
		texture_rect_4.texture.gradient = bg.bg_gradient


	if particles_packed:
		var x =particles_packed.instantiate()
		
		bg_manager.add_child(x)
