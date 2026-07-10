extends PlayerState

@onready var flappy: PlayerState = $"../flappy"
@onready var jumpp: AudioStreamPlayer2D = $"../flappy/Jumpp"

const state = Player.player_states.TRAINEND

func enter_state(player_node, data = {}):
	jumpp.play()

	super(player_node)
	player.velocity = Vector2( 250.0 ,-270.0)*player.speed_mult
	
func handle_input(delta):
	player.velocity += player.get_gravity() * delta
	if Input.is_action_just_pressed("jump"):
		flappy.jumpp.play()
		player.velocity.y = flappy.JUMP_VELOCITY
		player.icon.scale = Vector2(1.20,0.8)
		GameState.change_state("flappy")
	
