extends PlayerState


@export var state:= states.CART
@export var cart_col: CollisionShape2D
@export var boat_col: CollisionShape2D
@export var sprite: AnimatedSprite2D
@export var ray: RayCast2D

@onready var cart_anis: AnimationPlayer = $cart_anis
@onready var wheels: AnimationPlayer = $wheels

@onready var pcol: CollisionShape2D = $body/player_col/pcol
@onready var body: Sprite2D = $body
@onready var ccol: CollisionShape2D = $Area2D/ccol
@onready var dive: AudioStreamPlayer2D = $dive


const CART_GROUND = preload("uid://2jgekrcpbwug")
const CART_WATER = preload("uid://vtjgclurmxlb")

const SPEED = 250.0
const JUMP_VELOCITY = -465.0

enum states{BOAT,CART}
enum move_states{FALL,JUMP,MOVE,PAUSE}


var move_sound: AudioStreamPlayer

var curr_state: states
var m_state = move_states.MOVE
var cart_data: CartResource
var sprite1: AnimatedSprite2D

var can_change:= true
var in_state := false

func enter_state(player_node, _data = {}):
	ray.target_position = Vector2(0,28)
	in_state = true
	sprite1 = sprite.duplicate()
	sprite1.visible = true
	sprite1.play("cart")
	sprite1.z_index -=1
	sprite1.position = Vector2(-3,-14)
	body.add_child(sprite1)
	pcol.call_deferred("set_disabled",false)
	ccol.call_deferred("set_disabled",false)
	self.visible = true
	super(player_node)
	
	player.floor_snap_length = 10.0

	

func play_jump():

	cart_anis.play("jump")
	
func play_land():
	
	pass
	

func play_move():

	cart_anis.play("bob")



func set_cart():
	curr_state = states.CART
	cart_anis.stop()
	wheels.play("spin")

	wheels.speed_scale = 1.0
	cart_data = CART_GROUND
	if move_sound:
		move_sound.stop()
		move_sound.queue_free()
	move_sound = AudioManager.play_cart_sound(cart_data.move_sound)
	move_sound.play()
	
func set_water():
	curr_state = states.BOAT
	cart_anis.play("bob")
	wheels.speed_scale = 0.4
	cart_data = CART_WATER
	if move_sound:
		move_sound.stop()
		move_sound.queue_free()
	move_sound = AudioManager.play_cart_sound(cart_data.move_sound)
	move_sound.play()
	
func handle_input(delta):
	
	if ray.is_colliding() and player.is_on_floor():
		var n = ray.get_collision_normal()
		
		
		player.rotation = lerp(player.rotation ,atan2(n.y, n.x) +(PI/2),.2)
	
	match m_state:
		
		move_states.MOVE:
			
			
			player.velocity.x =  SPEED
			
			
			if not player.is_on_floor():
				if move_sound:
					move_sound.stop()
				cart_anis.play("fall")
				can_change = true
				m_state = move_states.FALL
			
			if Input.is_action_just_pressed("dive") and state == states.BOAT:
				dive.play()
				boat_col.call_deferred("set_disabled",true)
				m_state = move_states.PAUSE
				cart_anis.play("water_down")
				PlayerFollower.stop_cart_particles()
			
			elif Input.is_action_just_pressed("jump"):
				can_change = true
				move_sound.stop()
				cart_anis.play("jump")
				m_state = move_states.JUMP
				
			
			


		move_states.FALL:
			player.velocity += player.get_gravity() * delta
			if player.is_on_floor():
				
				cart_anis.play("RESET")
				cart_anis.seek(0, true)
				if curr_state == states.BOAT:
					cart_anis.play("plunge")
					
				else:
					cart_anis.play("ground_land")
					
				ParticleManager.play_particle(cart_data.land_particle,self.global_position+Vector2(30,0))
				AudioManager.play_cart_sound(cart_data.land_sound)
				move_sound.play() 
				
				
				if curr_state == states.BOAT:
					PlayerFollower.start_cart_particles()
				m_state = move_states.MOVE

		move_states.JUMP:
			cart_col.call_deferred("set_disabled",true)
			boat_col.call_deferred("set_disabled",true)
			PlayerFollower.stop_cart_particles()
			#AudioManager.play_cart_sound(cart_data.land_sound)
			player.velocity.y = JUMP_VELOCITY
			m_state = move_states.FALL
			
			
		move_states.PAUSE:
			pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	if !in_state or !can_change:
		return
	if body.is_in_group("water"):
		
		state = states.BOAT
		set_water()
		cart_col.call_deferred("set_disabled",true)
		boat_col.call_deferred("set_disabled",false)
		
	
	elif body.is_in_group("ground"):
		print('WHATTTTTTTTTTTTDSD')
		state = states.CART
		set_cart()
		cart_col.call_deferred("set_disabled",false)
		boat_col.call_deferred("set_disabled",true)
		
		

	
func exit_state():
	player.floor_snap_length = 5.0
	self.visible = false
	in_state = false
	sprite1.queue_free()
	pcol.call_deferred("set_disabled",true)
	ccol.call_deferred("set_disabled",true)
	cart_col.call_deferred("set_disabled",true)
	boat_col.call_deferred("set_disabled",true)



func _on_cart_anis_animation_finished(anim_name: StringName) -> void:
	if anim_name == "plunge":
		cart_anis.play("bob")
	elif anim_name == "water_down":
		PlayerFollower.start_cart_particles()
		m_state= move_states.MOVE
		boat_col.call_deferred("set_disabled",false)
		cart_anis.play("bob")

func get_pos():
	return body.global_position + Vector2(-4,-10)
