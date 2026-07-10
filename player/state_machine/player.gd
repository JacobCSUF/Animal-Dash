class_name Player
extends CharacterBody2D

@export var speed_mult_start = 1.0
@export var anim_text: AnimalResource
@export_enum("flappy", "float", "ball","cart") var selection: String = "flappy"
@export var is_test: = true
@export var icon: AnimatedSprite2D
@export var camera: Camera2D

@onready var cart: PlayerState = $states/cart

enum player_states{FLAPPY, DASH, RECOIL, FLOAT, STOP, GLIDE, THROW, BALL, CANNON
,TRAINEND}

@onready var animation_sounds: AnimationSounds = $AnimationSounds


enum StateType{
	FLAPPY,
	FLOAT,
	BALL,
	CART
}

var current_state: PlayerState
var current_state_name := "flappy"
var curr_group: StateType
var current_state1= player_states.FLAPPY


var waiting_for_jump := true
var is_dash = false

var speed_mult = 1.0



@onready var is_dash_timer: Timer = $is_dash_timer

func _ready():
	GameState.set_player(self,anim_text)
	icon.sprite_frames = GameState.animal_resource.animations
	GameState.connect("changed_state", Callable(self, "_on_changed_state"))
	if !current_state:
		change_state(selection)

func change_state(new_state_name: String, data: Dictionary = {}):
	if current_state:
		if current_state_name == "dash":
			is_dash_timer.start()
		current_state.exit_state()
	#print('new_state: ',new_state_name)
	
	
	current_state_name = new_state_name
	current_state = get_node("states/"+new_state_name)
	curr_group= current_state.state_type
	animation_sounds.handle_exit_group()
	
	animation_sounds.handle_new_group()
	
	
	if data.size() != 0 and current_state:
		current_state.enter_state(self, data)
	elif current_state:
		current_state.enter_state(self)

func _physics_process(delta: float) -> void:
	if curr_group == StateType.CART:
		GameState.player_location = cart.get_pos()
	else:
		GameState.player_location = global_position

	if waiting_for_jump:
		if Input.is_action_just_pressed("jump"):
			waiting_for_jump = false
			SongManager.play_song()
		return

	if current_state:
		current_state.handle_input(delta)
	move_and_slide()

func _on_changed_state(state, dict):
	change_state(state, dict)


func _on_is_dash_timer_timeout() -> void:
	is_dash = false
	
	
func modify_speed(added_speed: float):
	speed_mult += added_speed

	
	
func die():
	self.visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
