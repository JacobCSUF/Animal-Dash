extends PlayerState

@onready var state_animations: AnimationPlayer = $"../../state_animations"
@onready var ball_impact: AudioStreamPlayer2D = $BallImpact

@onready var sprite: Node2D = $"../../sprite"
@onready var timer: Timer = $Timer
@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var squish: AnimationPlayer = $"../../squish"

const state = Player.player_states.BALL

var SPEED = 245
var gravity = 475

enum states{GROUND, JUMP, LANDED}
var curr_state = states.GROUND

func enter_state(player_node, data = {}):
	#timer.start()
	super(player_node)
	match_state(states.LANDED,0)
	
	
var ray_len = 15.0
var n = Vector2(0,-1)
var flip =0
var a = 0.0
var vel = Vector2(1,0)

var old_ray_angle = 0

func handle_input(delta):
	match_state(curr_state,delta)


func match_state(state: states,delta):
	
	match state:
		states.GROUND:
			
			if ray_cast_2d.is_colliding():
				#print('WBEFORE',player.velocity)
				n = ray_cast_2d.get_collision_normal()
				
				ray_cast_2d.target_position = n * ray_len *-1
				#print(ray_cast_2d.target_position)
			
				a = atan2(n.y, n.x)
			
				
				player.velocity =Vector2.from_angle(a+ (PI/2)+flip*PI)* SPEED  *player.speed_mult                                          
				vel = player.velocity
				player.velocity = -n* 10 +vel
				
			elif !player.is_on_ceiling() and !player.is_on_wall() and !player.is_on_floor() and ! ray_cast_2d.is_colliding():
				
				#print(ray_cast_2d.target_position)
				a = atan2(n.y, n.x)
				player.velocity =Vector2.from_angle(a+ (PI/2)+flip*PI)* SPEED  *player.speed_mult   
				player.velocity += -1*n*gravity
				
				#print('WEEEEEEEEE',player.velocity)
				curr_state = states.LANDED
			
			
			if Input.is_action_just_pressed("jump"):
				curr_state = states.JUMP
		
	
		states.JUMP:
			ray_cast_2d.target_position *= -1
			player.velocity += n* gravity
			vel = player.velocity
			curr_state = states.LANDED
			
			
		states.LANDED:
			
			if (player.is_on_floor() or player.is_on_ceiling() or player.is_on_wall()):
				var v = vel.normalized()
			
				
				if player.is_on_floor():
					
					ray_cast_2d.target_position = Vector2(0,1)*ray_len
					#right
					if v.x > 0:
						player.velocity = Vector2.RIGHT *SPEED
						flip = 0
					else:
						player.velocity = Vector2.LEFT *SPEED
						flip = 1
						
						
				elif player.is_on_ceiling():
					
					ray_cast_2d.target_position = Vector2(0,-1)*ray_len
					if v.x > 0:
						player.velocity = Vector2.RIGHT *SPEED
						flip = 1
				
					else:
						player.velocity = Vector2.LEFT *SPEED
						flip = 0
				
				elif player.is_on_wall():
					
					
					####right wall
					if v.x >= 0:
						ray_cast_2d.target_position = Vector2(1,0)*ray_len
						### going up
						if v.y <= 0:
							
							player.velocity = Vector2.UP *SPEED
							flip = 0
						else:
						
							player.velocity = Vector2.DOWN *SPEED
							flip = 1
					
					###left wall
					else:
						ray_cast_2d.target_position = Vector2(-1,0)*ray_len
						if v.y <= 0:
							player.velocity = Vector2.UP *SPEED
							flip = 1
						else:
							player.velocity = Vector2.DOWN *SPEED
							flip = 0
						
				var r = ray_cast_2d.get_collision_normal()
				
			
						
			
				ball_impact.play()
				PlayerFollower.play_ball()
				curr_state = states.GROUND
				
	
func get_flip():
	if flip == 0:
		flip = 1
	else:
		flip = 0

func exit_state():
	squish.play("RESET")
	player.velocity = Vector2(0,0)
	flip =0
	n = Vector2(0,-1)
	

func _on_timer_timeout() -> void:

	curr_state = states.JUMP
