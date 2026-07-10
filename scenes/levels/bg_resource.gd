extends Resource
class_name BackGroundResource


@export_group("Particles")
@export var particle_texture: Texture2D
@export var particle_proccess_material: ParticleProcessMaterial
@export var p_color:= Color(0.0, 0.663, 0.671, 1.0)

@export_group("BackGround")
@export var bg_gradient: Gradient
@export var fog_color:= Color(0.737, 0.851, 1.0, 0.086)
