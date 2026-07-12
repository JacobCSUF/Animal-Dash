extends Node2D
class_name BaseObject

@export var group_number := 0
@export var sound_group_number := 0

@export_group("movement")
@export var bob: BobParams
@export var shrink: ShrinkParams
@export var spin: SpinParams
@export var sway: SwayParams

@export_group("components")
@export var shader_component: ShaderComponent
@export var movement_component: MovementComponent
@export var sound_inc_component: SoundIncComponent

@export var shader: ShaderMaterial

var overide_pos:Vector2 = Vector2(0,0)


func _ready() -> void:
	
	add_to_group("base_object")
	if bob:
		alter_movement(MovementComponent.MovementType.BOB,bob)
	
	if shrink:
		alter_movement(MovementComponent.MovementType.SHRINK,shrink)
	
	if spin:
		alter_movement(MovementComponent.MovementType.SPIN,spin)
	
	if sway:
		alter_movement(MovementComponent.MovementType.SWAY,sway)
	
	if sound_inc_component and (sound_group_number != 0):
		sound_inc_component.set_number(sound_group_number)
		
	if overide_pos != Vector2(0,0):
		self.position += overide_pos
	
	if shader:
		set_shader(shader)
############SETS UP TRIGGER ROUTES ####################################
var triggers: Array[Trigger]
# Called when the node enters the scene tree for the first time.
func set_up_trigger(trigger):
	var x = Trigger.new()
	x.responses = trigger
	x.set_external_path(self)
	add_child(x)
	triggers.append(x)
		
	
func route(index):
	if index >= 0 and index <triggers.size():
		triggers[index].trigger()


	
func set_shader(mat: ShaderMaterial):
	if !shader_component:
		shader_component = ShaderComponent.new()
		add_child(shader_component)
	shader_component.material_change(mat)
	
	for child in get_children():
		if child is BaseObject:
		
			child.set_shader(mat)



func alter_movement(move_type: MovementComponent.MovementType, data = {}):
	if !movement_component:
		movement_component =  MovementComponent.new()
		add_child(movement_component)
		movement_component.set_object(self)
	
	match move_type:
		MovementComponent.MovementType.BOB:
			movement_component.bob(data)
		
		MovementComponent.MovementType.SWAY:
			movement_component.sway(data)
			
		MovementComponent.MovementType.MOVE:
			movement_component.move_in_line(data)
		
		MovementComponent.MovementType.SHRINK:
			movement_component.shrink(data)
			
		MovementComponent.MovementType.SPIN:
			movement_component.spin(data)
