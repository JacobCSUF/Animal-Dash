extends ResponseResource
class_name ParticleResource


@export var particle_type: ParticleManager.particles
@export var position: NodePath
@export var texture: Texture2D

func _init():
	r_type = Responses.PARTICLE
	set_repeat(true)
	has_target = false
	

func set_up():
	if position:
		paths["position"] = position



func execute(ctx: Context,pos):
	if position:
		var p= paths["position"]
		
		ParticleManager.play_particle(particle_type,p.global_position,texture)
