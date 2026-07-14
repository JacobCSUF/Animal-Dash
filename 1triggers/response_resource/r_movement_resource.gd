extends ResponseResource
class_name MovementResource

@export var target_path: NodePath
@export var group := 0
@export var group_delay:= 0.0

@export_group("Bob")
@export var bob:= false
@export var height:= 5.0
@export var duration:= 0.50
@export var speed:= 1.0
@export var random:= true

@export_group("Move in line")
@export var move_in_line:= false
@export var direction:= Vector2(1,0)
@export var distance:= 100
@export var duration1:= 1.0
@export var loop:= false
@export var reverse:= false

@export_group("Sound")
@export var play_sound:= false
@export var sound: AudioManager.Sound
@export var is_pos:= false
@export var sound_params: SoundParams


func _init():
	r_type = Responses.APPEAR
	set_repeat(false)

func set_up():
	set_group(group,group_delay)
	


func set_up_group(objects: Array[BaseObject]):
	
	for i in objects:
		target_node = i
		set_up()
		if reverse:
			AnimationUtils.obj_start_pos(i,distance,direction)
		
func execute(ctx: Context,pos):
	
	if bob:
		var b = BobParams.new()
		b.height = height
		b.duration = duration
		b.speed = speed
		b.random = random
		target_node.alter_movement(MovementComponent.MovementType.BOB,b)
		
		
	elif move_in_line:
		var m = MoveLineParams.new()
		m.direction = direction
		m.distance = distance
		m.duration = duration1
		m.loop = loop
		m.reverse = reverse
		target_node.alter_movement(MovementComponent.MovementType.MOVE,m)
		
		
	if play_sound:
		if is_pos:
			AudioManager.play_sound(sound,pos,sound_params)
		else:
			AudioManager.play_sound(sound,Vector2(0,0),sound_params)
