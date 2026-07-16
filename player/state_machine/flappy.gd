extends PlayerState
@onready var jumpp: AudioStreamPlayer2D = $Jumpp


const state = Player.player_states.FLAPPY
const SPEED = 160.0    
const JUMP_VELOCITY = -270.0

func enter_state(player_node, _data = {}):
	
	super(player_node)
	
	player.icon.rotation_degrees = 0
	

var can_dash = true
func handle_input(delta):
	
	player.icon.scale += Vector2(-delta*1.5,delta*1.5)
	player.icon.scale.x = max(player.icon.scale.x,1)
	player.icon.scale.y = min(player.icon.scale.y,1)
	
	
	if not player.is_on_floor():
		
		player.velocity += player.get_gravity() * delta * .95

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jumpp.play()
		player.velocity.y = JUMP_VELOCITY
		player.icon.scale = Vector2(1.20,0.8)
	

	
	if player.is_test:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			
			player.velocity.x = move_toward(player.velocity.x, direction * SPEED * player.speed_mult,30* delta * 60)
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED * delta * 60)
			
	else:
		
		player.velocity.x = move_toward(player.velocity.x,SPEED * player.speed_mult,75* delta * 60)
	
		
		
	if Input.is_action_just_pressed("e"):
		player.start_dash()

func exit_state():
	player.icon.scale = Vector2(1,1)
