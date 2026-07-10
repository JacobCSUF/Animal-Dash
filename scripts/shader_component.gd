extends Node2D
class_name  ShaderComponent

@export var sprites: Array[CanvasItem]
@export var shader_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !sprites:
		var p = get_parent()
		if p:
			for child in p.get_children():
				if (child is Sprite2D or child is AnimatedSprite2D) and child != self:
					
					sprites.append(child)
	
	refresh_materials()

func set_shader(mat: ShaderMaterial):
	shader_material = mat

func material_change(mat: ShaderMaterial):
	set_shader(mat)
	refresh_materials()

func refresh_materials():
	if shader_material:
		for sprite in sprites:
			if sprite:
				sprite.material = shader_material
