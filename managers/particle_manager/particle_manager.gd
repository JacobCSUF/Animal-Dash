extends Node

enum particles{
	BLOCK,
	ICE,
	WALL,
	DEATH,
	RAILHIT,
	SPLASH,
	WAVE,
	BLANK
	
	
}

var particle_dict: Dictionary[particles,PackedScene] = {
	particles.BLOCK: preload("uid://do2jvpda8ly46"),
	particles.ICE: preload("uid://ylv3sfuqbt7v"),
	particles.WALL: preload("uid://dntngraxq82x6"),
	particles.DEATH: preload("uid://bofowndomeiut"),
	particles.RAILHIT: preload("uid://mb45wu5tanuv"),
	particles.SPLASH: preload("uid://berse50gptghu"),
	particles.WAVE: preload("uid://cdsgxus8ex8xi"),
	particles.BLANK: preload("uid://cdsgxus8ex8xi")
}


func play_particle(particle: particles, pos: Vector2, tex_overide: Texture2D = null,color: Color = Color()):
	if particle == particles.BLANK:
		return
	var ptcl: GPUParticles2D = particle_dict[particle].instantiate()
	ptcl.global_position = pos
	
	ptcl.z_index = 20
	
	if tex_overide:
		ptcl.texture = tex_overide
	if color!= Color():
		ptcl.modulate = color
	#ptcl.amount = data.amount
	#ptcl.process_material.emission_sphere_radius = data.radius
	#ptcl.modulate = data.color
	add_child(ptcl)
	ptcl.emitting = true
	ptcl.finished.connect(ptcl.queue_free)
	
func play_duplicate(particl: GPUParticles2D,pos):
	var gpu = particl.duplicate()
	gpu.position = pos
	get_tree().get_root().add_child(gpu)
	gpu.emitting = true
	gpu.finished.connect(gpu.queue_free)
	
func get_particle_packed(particle: particles):
	return particle_dict[particle]
	
func return_particle(particle: particles):
	if particle == particles.BLANK:
		return
	return particle_dict[particle].instantiate()
