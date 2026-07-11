extends BaseObject

@export var up:=false


@export_group("Triggers")
@export var area_entered: Array[ResponseResource]
@export var spin_started: Array[ResponseResource]
@export var spin_finished: Array[ResponseResource]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wind_up: AudioStreamPlayer2D = $wind_up


var can_spin = false
var is_spin = false
var player: CharacterBody2D

var mult := 1.0

func _ready() -> void:
	super()
	set_up_trigger(area_entered)
	set_up_trigger(spin_started)
	set_up_trigger(spin_finished)
	
	if up:
		animation_player.play_backwards("spin")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_spin:
		
		GameState.change_state("stop")
		can_spin = false
		spin_setup()
	
		
	if is_spin:
		circle()


var angle = 0.0

var start_angle = 0.0
func spin_setup():
	triggers[1].trigger()
	wind_up.play()
	var angle1 = global_position.angle_to_point(player.global_position)
	var deg =rad_to_deg(angle1)
	if deg <= 0:
		deg = 360 + deg
	
	start_angle = deg_to_rad(deg)
	set_pos(start_angle)
	
	angle += start_angle
	is_spin = true
	
	mult = GameState.player.get_partial_mult(16.5,.4)

func circle():
	
	if up:
		angle  -= mult * get_process_delta_time()
	else:
		angle += mult * get_process_delta_time()
	
	if !up:
		if rad_to_deg(angle) >= 640:
			is_spin = false
			GameState.change_state("throw",{"dir":"down"})
			triggers[2].trigger()
	else:
		if rad_to_deg(angle) <= -280:
			is_spin = false
			GameState.change_state("throw",{"dir":"up"})
			triggers[2].trigger()
	set_pos(angle)

func set_pos(start1):
	var x = cos(start1)
	var y = sin(start1)
	player.global_position.x = 36 * x + global_position.x
	player.global_position.y = 36 * y + global_position.y
	




func _on_direct_area_area_entered(area: Area2D) -> void:
	can_spin = true
	player = GameState.player


func _on_direct_area_area_exited(area: Area2D) -> void:
	can_spin = false
	is_spin = false
