extends ResponseResource
class_name RouteResource

@export var target_path: NodePath
@export var route_index: int



func _init():
	r_type = Responses.ROUTE
	set_repeat(true)

func set_up():
	pass

func execute(ctx: Context,pos):
	target_node.route(route_index)
	
