extends ResponseResource
class_name Audio1Resource


@export var sound: AudioManager.Sound
@export var position: NodePath
@export var params: SoundParams

func _init():
	r_type = Responses.AUDIO
	set_repeat(true)
	has_target = false
	

func set_up():
	if position:
		paths["position"] = position



func execute(ctx: Context,pos):
	if position:
		var p= paths["position"]
		AudioManager.route_sound(sound,p.global_position,params)
	else:
		AudioManager.route_sound(sound,Vector2(0,0),params)
