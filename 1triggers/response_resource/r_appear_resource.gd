extends ResponseResource
class_name AppearResource


@export var target_path: NodePath
@export var group := 0

func _init():
	r_type = Responses.APPEAR
	set_repeat(false)

func set_up():
	if target_node:
		target_node.visible = false
		target_node.process_mode = Node.PROCESS_MODE_DISABLED
	set_group(group)
		
func execute(ctx: Context,pos):
	ctx.appear.handle(pos,target_node)
