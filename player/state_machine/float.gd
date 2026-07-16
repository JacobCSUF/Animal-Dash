extends PlayerState
const SPEED = 190.0     
const FLOAT_VELOCITY = -20.0


@onready var float_wind: AudioStreamPlayer2D = $"../../AnimationSounds/FloatWind"


const state = Player.player_states.FLOAT

func enter_state(player_node, _data = {}):
 	
	super(player_node)
	

	
func handle_input(delta):
	
	if not Input.is_action_pressed("jump"):
		
		player.icon.rotation_degrees = lerp(player.icon.rotation_degrees,15.0, .05 * delta * 60)
		
		player.velocity.y += -FLOAT_VELOCITY * delta * 60
		player.velocity.y = min(player.velocity.y,300)
	
	elif Input.is_action_pressed("jump"):
		player.icon.rotation_degrees = lerp(player.icon.rotation_degrees,-15.0, .05 * delta * 60)
		player.velocity.y += FLOAT_VELOCITY * delta * 60
		player.velocity.y = max(player.velocity.y,-300)
	
	var target_pitch = remap(player.velocity.y, -300, 300, 1.9, 0.5)
	float_wind.pitch_scale = lerp(float_wind.pitch_scale, target_pitch, 0.05 * delta * 60)
	
	if player.is_test:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			
			player.velocity.x = direction * SPEED * player.speed_mult
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, 6 * delta * 60)
	else:
		player.velocity.x =  SPEED * player.speed_mult
	
		
	if Input.is_action_just_pressed("e"):
		player.change_state("float_glide")
		
func exit_state():
	
	player.icon.rotation_degrees = 0
	
