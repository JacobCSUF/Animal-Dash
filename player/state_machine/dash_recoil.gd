extends PlayerState
var speed := -250


@onready var player_camera: Camera2D = $"../../../player_camera"

const state = Player.player_states.RECOIL

func enter_state(player_node, _data: Dictionary = {}):
	super(player_node)
	player.velocity = Vector2(speed, 0)
	player.icon.scale = Vector2(0.65, 1.35)
	_do_camera_zoom()
	player.icon.scale = Vector2(0.45,1.55)
	var tween = create_tween()
	tween.tween_property(player.icon, "scale", Vector2(1.0,1.0), .25)


var ready1 = false
func on_tween_finished():
	ready1 = true
func _do_camera_zoom():
	pass
	#var tween = player_camera.create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.tween_property(player_camera, "zoom", Vector2(1.25, 1.25), 0.15)
	#tween.tween_property(player_camera, "zoom", Vector2(1.1, 1.1), 0.35)
func handle_input(delta):
	
	player.velocity.x += 8 * delta * 60
	if Input.is_action_just_pressed("e"):
		player.change_state("dash")
