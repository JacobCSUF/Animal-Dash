extends ResponseResource
class_name BGResource

@export var bg: BGParams

func _init():
	r_type = Responses.BGROUND
	has_target = false
	set_repeat(true)

	

func execute(ctx: Context,pos):
	GameState.handle_bg(bg)
