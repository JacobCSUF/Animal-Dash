extends ResponseResource
class_name DefaultResource

@export var target_path: NodePath
@export_range(1,3) var default_range: int = 2

func _init():
	
	r_type = Responses.DEFAULT

func execute(ctx: Context,pos):
	if default_range == 1:
		
		if target_node.has_method("default_1"):
			target_node.default_1()
