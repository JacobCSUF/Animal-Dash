extends ResponseResource
class_name ShaderResource

@export var shader_mat: ShaderMaterial
@export var target_path: NodePath
@export var group := 0


func _init():
	r_type = Responses.SHADER
	set_repeat(false)

func set_up():
	
	set_group(group)
		
func execute(ctx: Context,pos):
	target_node.set_shader(shader_mat)
