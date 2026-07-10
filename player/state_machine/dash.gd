extends PlayerState
var speed = 500
var duration = 0.165
var dash_timer = 0.0


const state = Player.player_states.DASH

@onready var is_dash_timer: Timer = $"../../is_dash_timer"



var end_state: = "flappy"
func enter_state(player_node,data: Dictionary = {}):
	
	var amount = 5
	var time = 0.2
	end_state = "flappy"
	
	
#	dict: {"time":0, "end_state", "dir":Vector2(0,0)
	super(player_node)
	
	
	AudioManager.play_sound(AudioManager.Sound.DASH)
	is_dash_timer.stop()
	
	player.is_dash = true
	
	if data.has("time"):
		duration  = data["time"]
		
	if data.has("speed"):
		speed = data["speed"]
	
	if data.has("point"):
		var tween = create_tween()
		tween.tween_property(player, "global_position", data["point"], 0.02)

		
	
	if data.has("dir"):
		player.velocity = speed*data["dir"] 
	
	if data.has("end_state"):
		end_state = data["end_state"]
	
	else:
		player.velocity = Vector2(speed + (player.speed_mult-1)*100,0)
		
	dash_timer = duration
	
	
	if data.has("amount"):
		amount = data["amount"]
		PlayerFollower.play_dash(amount,data["time"])
	else:
		PlayerFollower.play_dash()

func handle_input(delta):
	
	dash_timer -= delta
	if dash_timer <= 0:
		
		player.change_state(end_state)

func exit_state():
	
	speed = 500
	duration = 0.165
	dash_timer = 0.0
	
